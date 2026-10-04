import Carbon
import XCTest
@testable import BochaSwitcher

@MainActor
final class DiagnosticsTests: XCTestCase {
    func testPrintSpelling() {
        let samples = ["ztn", "ghbdtn", "jrf", "zt", "rjl", "lfdfq", "nj", "vbh", "pfdnhf", "cjpdjy", "nhfkfkf", "qwrt", "děkuji", "škola", "dekuji", "skola"]
        for lang in ["cs", "de", "en"] {
            print("DIAG spell \(lang): " + samples.map { "\($0)=\(Dict.isValidWord($0, lang: lang) ? "Y" : "n")" }.joined(separator: " "))
        }
    }

    func testPrintCzechDeadKeys() throws {
        let filter = [kTISPropertyInputSourceID as String: "com.apple.keylayout.Czech"] as CFDictionary
        let list = TISCreateInputSourceList(filter, true)!.takeRetainedValue() as! [TISInputSource]
        let data = Unmanaged<CFData>.fromOpaque(TISGetInputSourceProperty(list[0], kTISPropertyUnicodeKeyLayoutData)).takeUnretainedValue() as Data
        for (dead, shift) in [(UInt16(24), false), (24, true), (42, false)] {
            let line = [UInt16(17), 2, 45, 0, 14, 8, 32, 6].map { base -> String in
                let s = DynamicKeyMapping.composeKeys([TypedKey(keyCode: dead, shift: shift, caps: false), TypedKey(keyCode: base, shift: false, caps: false)], layoutData: data) ?? "nil"
                return "\(base):\(s)(\(s.unicodeScalars.map { String($0.value, radix: 16) }.joined(separator: "+")))"
            }.joined(separator: " ")
            print("DIAG dead \(dead) shift=\(shift): \(line)")
        }
    }
}
