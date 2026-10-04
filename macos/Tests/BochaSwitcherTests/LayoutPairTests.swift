import Carbon
import XCTest
@testable import BochaSwitcher

// Логика пар раскладок на настоящих раскладках macOS: русская ↔ немецкая, русская ↔ чешская,
// немецкая ↔ английская. Раскладки берутся из системы (установлены всегда, даже если не включены).

/// Данные раскладки `com.apple.keylayout.<id>`.
private func layoutData(_ id: String) throws -> Data {
    let filter = [kTISPropertyInputSourceID as String: "com.apple.keylayout." + id] as CFDictionary
    guard let list = TISCreateInputSourceList(filter, true)?.takeRetainedValue() as? [TISInputSource],
          let source = list.first,
          let ptr = TISGetInputSourceProperty(source, kTISPropertyUnicodeKeyLayoutData) else {
        throw XCTSkip("layout \(id) is not installed")
    }
    return Unmanaged<CFData>.fromOpaque(ptr).takeUnretainedValue() as Data
}

private let candidates: [TypedKey] = (UInt16(0)...50).flatMap { code in
    [TypedKey(keyCode: code, shift: false, caps: false), TypedKey(keyCode: code, shift: true, caps: false)]
}

/// Клавиши, которыми `word` набирается в раскладке: одиночная клавиша или пара
/// «мёртвая клавиша + буква» для составных символов (чешское «ť» = «ˇ» + «t»).
private func keys(for word: String, in data: Data) -> [TypedKey]? {
    var result: [TypedKey] = []
    for ch in word {
        let target = String(ch)
        if let k = candidates.first(where: { DynamicKeyMapping.composeKeys([$0], layoutData: data) == target }) {
            result.append(k)
            continue
        }
        var found: [TypedKey]?
        search: for dead in candidates {
            for base in candidates where DynamicKeyMapping.composeKeys([dead, base], layoutData: data) == target {
                found = [dead, base]
                break search
            }
        }
        guard let pair = found else { return nil }
        result += pair
    }
    return result
}

/// Что получится, если слово `word` языка раскладки `intended` набрать при включённой `actual`,
/// и во что приложение его переведёт обратно.
private func mistype(_ word: String, intended: String, actual: String) throws -> (original: String, converted: String)? {
    let intendedData = try layoutData(intended)
    let actualData = try layoutData(actual)
    let typed = try XCTUnwrap(keys(for: word, in: intendedData), "no keys for «\(word)» in \(intended)")
    return DynamicKeyMapping.convertKeys(typed, sourceData: actualData, targetData: intendedData)
}

final class KeyConversionTests: XCTestCase {
    func testRussianTypedInGerman() throws {
        let p = try XCTUnwrap(mistype("привет", intended: "RussianWin", actual: "German"))
        XCTAssertEqual(p.original, "ghbdtn")
        XCTAssertEqual(p.converted, "привет")
        let q = try XCTUnwrap(mistype("хорошо", intended: "RussianWin", actual: "German"))
        XCTAssertEqual(q.original, "üjhjij")
        XCTAssertEqual(q.converted, "хорошо")
    }

    func testGermanTypedInRussian() throws {
        let p = try XCTUnwrap(mistype("straße", intended: "German", actual: "RussianWin"))
        XCTAssertEqual(p.original, "ыекф-у")
        XCTAssertEqual(p.converted, "straße")
        let q = try XCTUnwrap(mistype("Zeitung", intended: "German", actual: "RussianWin"))
        XCTAssertEqual(q.original, "Нушегтп")
        XCTAssertEqual(q.converted, "Zeitung")
    }

    func testRussianTypedInCzechQWERTZ() throws {
        let p = try XCTUnwrap(mistype("нет", intended: "RussianWin", actual: "Czech"))
        XCTAssertEqual(p.original, "ztn")
        XCTAssertEqual(p.converted, "нет")
    }

    func testCzechDiacriticsTypedInRussian() throws {
        let p = try XCTUnwrap(mistype("děkuji", intended: "Czech", actual: "RussianWin"))
        XCTAssertEqual(p.original, "в2лгош")
        XCTAssertEqual(p.converted, "děkuji")
    }

    /// «ť» в чешской — мёртвая «ˇ» + «t»: в перевод должна попасть составная буква, а не «ˇt».
    func testCzechDeadKeyComposesInTarget() throws {
        let p = try XCTUnwrap(mistype("chuť", intended: "Czech", actual: "RussianWin"))
        XCTAssertEqual(p.converted, "chuť")
        XCTAssertEqual(p.original.count, 5, "original keeps one char per key (erase count)")
    }

    /// «ё» в немецкой раскладке попадает на мёртвую «^»: стирание по счёту клавиш разъехалось бы
    /// с полем, поэтому буферный путь честно отказывается.
    func testSourceDeadKeyBails() throws {
        XCTAssertNil(try mistype("ёлка", intended: "RussianWin", actual: "German"))
    }

    func testEnglishTypedInGerman() throws {
        let p = try XCTUnwrap(mistype("yes", intended: "US", actual: "German"))
        XCTAssertEqual(p.original, "zes")
        XCTAssertEqual(p.converted, "yes")
    }
}

@MainActor
final class DetectorTests: XCTestCase {
    private func verdict(_ typed: String, _ converted: String, _ current: String, _ other: String) -> LayoutVerdict {
        LayoutDetector.decide(typed: typed, converted: converted, currentLang: current, otherLang: other, capsLock: false)
    }

    func testDictionariesAvailable() {
        for lang in ["ru", "en", "de", "cs"] { XCTAssertTrue(Dict.isAvailable(lang), lang) }
        for lang in ["ru", "en", "de"] { XCTAssertTrue(Dict.isReliable(lang), lang) }
    }

    /// Чешский словарь macOS принимает любую бессмыслицу — детектор опирается на вторую сторону.
    /// Если тест упал, в macOS появился настоящий чешский словарь: обновите заметки в ShortWords/decide.
    func testCzechDictionaryIsBlind() {
        XCTAssertFalse(Dict.isReliable("cs"))
    }

    func testGermanNounsInLowercase() {
        XCTAssertTrue(Dict.isValidWordIgnoringCase("zeitung", lang: "de"))
        XCTAssertTrue(Dict.isValidWordIgnoringCase("straße", lang: "de"))
    }

    func testConvertsWrongLayout() {
        XCTAssertEqual(verdict("ghbdtn", "привет", "de", "ru"), .switchToConverted)
        XCTAssertEqual(verdict("ztn", "нет", "cs", "ru"), .switchToConverted)
        XCTAssertEqual(verdict("ыекф-у", "straße", "ru", "de"), .switchToConverted)
        XCTAssertEqual(verdict("нушегтп", "zeitung", "ru", "de"), .switchToConverted)
        XCTAssertEqual(verdict("zes", "yes", "de", "en"), .switchToConverted)
    }

    func testKeepsCorrectWords() {
        XCTAssertEqual(verdict("danke", "вфтлу", "de", "ru"), .keep)
        XCTAssertNotEqual(verdict("děkuji", "в2лгош", "cs", "ru"), .switchToConverted)
        XCTAssertEqual(verdict("name", "name", "de", "en"), .keep)
    }

    /// Направление «в чешский» без словаря не проверить — только ручной ⌥ (и частые короткие слова).
    func testCzechTypedInRussianLeftToTrigger() {
        XCTAssertEqual(verdict("в2лгош", "děkuji", "ru", "cs"), .undecided)
    }

    func testShortWords() {
        XCTAssertEqual(verdict("zt", "не", "cs", "ru"), .switchToConverted)
        XCTAssertEqual(verdict("6у", "že", "ru", "cs"), .switchToConverted)
        XCTAssertEqual(verdict("vs", "мы", "de", "ru"), .keep, "guard token typed in German stays")
        XCTAssertEqual(verdict("ze", "ну", "cs", "ru"), .keep, "frequent on both sides — never auto")
        XCTAssertEqual(verdict("mz", "my", "de", "en"), .switchToConverted)
    }
}

/// Снимок аудита коротких слов: пары, где частое слово одной стороны набирается как частое
/// слово другой. Такие слова авто-путём не конвертятся. Тест падает, если правка списков
/// добавит новую коллизию — тогда её нужно осознанно внести сюда.
final class ShortWordsAuditTests: XCTestCase {
    private func image(_ word: String, from: Data, to: Data) -> String? {
        guard let k = keys(for: word, in: from) else { return nil }
        return DynamicKeyMapping.composeKeys(k, layoutData: to)
    }

    /// Охранные токены (vs/dj/kb/…) пересекаются намеренно — их образ и есть частое ru-слово.
    private let guards: Set<String> = ["vs", "dj", "kb", "jr", "bp", "ds", "ye"]

    private func collisions(_ a: String, _ langA: String, _ b: String, _ langB: String) throws -> Set<String> {
        let da = try layoutData(a), db = try layoutData(b)
        let wa = try XCTUnwrap(ShortWords.common(langA)), wb = try XCTUnwrap(ShortWords.common(langB))
        var found: Set<String> = []
        for w in wa { if let i = image(w, from: da, to: db), i != w, wb.contains(i.lowercased()),
                         !guards.contains(w), !guards.contains(i) { found.insert("\(w)→\(i)") } }
        for w in wb { if let i = image(w, from: db, to: da), i != w, wa.contains(i.lowercased()),
                         !guards.contains(w), !guards.contains(i) { found.insert("\(w)→\(i)") } }
        return found
    }

    func testRussianGerman() throws {
        XCTAssertEqual(try collisions("RussianWin", "ru", "German", "de"), [])
    }

    func testRussianCzech() throws {
        XCTAssertEqual(try collisions("RussianWin", "ru", "Czech", "cs"), ["ну→ze", "ze→ну"])
        XCTAssertEqual(try collisions("RussianWin", "ru", "Czech-QWERTY", "cs"), [])
    }

    func testEnglishGerman() throws {
        XCTAssertEqual(try collisions("US", "en", "German", "de"), [])
    }
}
