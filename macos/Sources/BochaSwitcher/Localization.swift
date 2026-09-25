import Foundation

/// Локализация интерфейса: английский и русский (вкомпилированные строки)
enum L10n {
    // MARK: - Меню
    static var menuAutoSwitch: String { s("menu.autoSwitch") }
    static var menuCheckPermissions: String { s("menu.checkPermissions") }
    static var menuSettings: String { s("menu.settings") }
    static var menuCheckUpdates: String { s("menu.checkUpdates") }
    static var menuQuit: String { s("menu.quit") }

    // MARK: - Визард разрешений
    static var wizardPermissionsResetTitle: String { s("wizard.permissionsReset.title") }
    static var wizardPermissionsResetText: String { s("wizard.permissionsReset.text") }
    static var permissionsOkTitle: String { s("wizard.permissionsOk.title") }
    static var permissionsOkText: String { s("wizard.permissionsOk.text") }
    static var wizardLaunchAtLoginTitle: String { s("wizard.launchAtLogin.title") }
    static var wizardLaunchAtLoginText: String { s("wizard.launchAtLogin.text") }
    static var wizardYes: String { s("wizard.yes") }
    static var wizardNo: String { s("wizard.no") }

    // MARK: - Настройки
    static var settingsTitle: String { s("settings.title") }
    static var settingsTabGeneral: String { s("settings.tab.general") }
    static var settingsTabAdvanced: String { s("settings.tab.advanced") }
    static var settingsAutoSwitch: String { s("settings.autoSwitch") }
    static var settingsLaunchAtLogin: String { s("settings.launchAtLogin") }
    static var settingsCheckUpdates: String { s("settings.checkUpdates") }
    static var settingsCheckUpdatesHint: String { s("settings.checkUpdates.hint") }
    static var settingsSmartConversion: String { s("settings.smartConversion") }
    static var settingsSmartConversionHint: String { s("settings.smartConversion.hint") }
    static var settingsConvertByText: String { s("settings.convertByText") }
    static var settingsConvertByTextHint: String { s("settings.convertByText.hint") }
    static var settingsConvertWholeLine: String { s("settings.convertWholeLine") }
    static var settingsConvertWholeLineHint: String { s("settings.convertWholeLine.hint") }
    static var settingsLayout1: String { s("settings.layout1") }
    static var settingsLayout2: String { s("settings.layout2") }
    static var settingsAutoDetect: String { s("settings.autoDetect") }
    static var settingsDebugLog: String { s("settings.debugLog") }
    static var settingsSecureNotice: String { s("settings.secureNotice") }
    static var settingsShowLog: String { s("settings.showLog") }
    static var settingsSendLog: String { s("settings.sendLog") }
    static var settingsHotkey: String { s("settings.hotkey") }
    static var menuProjectPage: String { s("menu.projectPage") }
    static var whatsNewTitle: String { s("whatsnew.title") }
    static var whatsNewBody: String { s("whatsnew.body") }
    static var whatsNewMore: String { s("whatsnew.more") }
    static var settingsLanguage: String { s("settings.language") }
    static var settingsLanguageAuto: String { s("settings.languageAuto") }

    static var settingsPerAppLayout: String { s("settings.perAppLayout") }
    static var settingsTrigger: String { s("settings.trigger") }
    static var settingsTriggerRightOnly: String { s("settings.triggerRightOnly") }
    static var settingsTriggerDoubleTap: String { s("settings.triggerDoubleTap") }
    static var settingsTriggerHint: String { s("settings.triggerHint") }
    static var menuAutoConvert: String { s("menu.autoConvert") }
    static var menuKeySound: String { s("menu.keySound") }
    static var menuRemoteDesktop: String { s("menu.remoteDesktop") }
    static var menuCaretFlag: String { s("menu.caretFlag") }
    static var settingsSwitchHotkey: String { s("settings.switchHotkey") }
    static var settingsCaseHotkey: String { s("settings.caseHotkey") }
    static var settingsSwitchHotkeyOff: String { s("settings.switchHotkey.off") }
    static var settingsSwitchHotkeyBusy: String { s("settings.switchHotkey.busy") }
    static var settingsCaretFlag: String { s("settings.caretFlag") }
    static var settingsCaretFlagHint: String { s("settings.caretFlag.hint") }
    static var settingsAutoConvert: String { s("settings.autoConvert") }
    static var settingsAutoConvertHint: String { s("settings.autoConvert.hint") }
    static var settingsTabExceptions: String { s("settings.tab.exceptions") }
    static var settingsRemoteDesktopHint: String { s("settings.remoteDesktop.hint") }
    static var settingsExceptionsApps: String { s("settings.exceptions.apps") }
    static var settingsExceptionsNever: String { s("settings.exceptions.never") }
    static var settingsExceptionsAlways: String { s("settings.exceptions.always") }
    static var settingsAddWordPrompt: String { s("settings.exceptions.addWordPrompt") }
    static var commonAdd: String { s("common.add") }
    static var commonCancel: String { s("common.cancel") }
    static func learnQuestion(_ word: String) -> String { String(format: s("learn.question"), word) }
    static var learnAdd: String { s("learn.add") }
    static var learnNotNow: String { s("learn.notNow") }
    static var onboardAutoConvertTitle: String { s("onboard.autoConvert.title") }
    static var onboardAutoConvertText: String { s("onboard.autoConvert.text") }

    // MARK: - Обновления
    static var updateAvailable: String { s("update.available") }
    static var updateBeta: String { s("update.beta") }
    static var securePausedTitle: String { s("secure.paused.title") }
    static var securePausedBody: String { s("secure.paused.body") }
    static var securePausedUnknownApp: String { s("secure.paused.unknownapp") }
    static var updateNewVersion: String { s("update.newVersion") }
    static var updateDownload: String { s("update.download") }
    static var updateInstallRestart: String { s("update.installRestart") }
    static var updateSkip: String { s("update.skip") }
    static var updateLater: String { s("update.later") }
    static var updateUpToDate: String { s("update.upToDate") }
    static var updateLatestInstalled: String { s("update.latestInstalled") }
    static var updateCheckFailed: String { s("update.checkFailed") }
    static var updateCheckFailedDetail: String { s("update.checkFailedDetail") }
    static var updateInstallFailed: String { s("update.installFailed") }
    static var updateDownloadCorrupted: String { s("update.downloadCorrupted") }
    static var updateIntegrityFailed: String { s("update.integrityFailed") }
    static var updateDownloadFailed: String { s("update.downloadFailed") }

    // MARK: - Language names (для выпадающего списка)

    /// Названия языков на их родном языке
    static let languageNames: [(code: String, name: String)] = [
        ("en", "English"),
        ("ru", "Русский"),
    ]

    // MARK: - Private

    nonisolated(unsafe) private static var currentLang: String = detectLanguage()

    static let supportedLanguages = Set(["en", "ru"])

    private static func detectLanguage() -> String {
        // Проверяем принудительный язык из настроек
        let forced = UserDefaults.standard.string(forKey: "com.bochaswitcher.interfaceLanguage") ?? ""
        if !forced.isEmpty && supportedLanguages.contains(forced) {
            return forced
        }
        // Авто-определение по системе
        let preferred = Locale.preferredLanguages.first ?? "en"
        let code = String(preferred.prefix(2))
        return supportedLanguages.contains(code) ? code : "en"
    }

    /// Перезагрузить язык (вызывается при смене в настройках)
    static func reloadLanguage() {
        currentLang = detectLanguage()
    }

    private static func s(_ key: String) -> String {
        strings[currentLang]?[key] ?? strings["en"]![key] ?? key
    }

    // MARK: - Все строки

    private static let strings: [String: [String: String]] = [
        // ========== ENGLISH ==========
        "en": [
            "menu.autoSwitch": "Enable Bocha Switcher",
            "menu.checkPermissions": "Check Permissions…",
            "menu.settings": "Settings…",
            "menu.checkUpdates": "Check for Updates…",
            "menu.projectPage": "Project Page",
            "whatsnew.title": "What's New in Bocha Switcher",
            "whatsnew.body": "Bug fixes and improvements.",
            "whatsnew.more": "Full release notes",
            "menu.quit": "Quit",

            "wizard.permissionsReset.title": "Permissions Reset After Update",
            "wizard.permissionsReset.text": "macOS has reset permissions because the app was updated.\n\nBocha Switcher will remove old entries and request permissions again.\nYou just need to flip the toggles.",
            "wizard.permissionsOk.title": "All Permissions Granted",
            "wizard.permissionsOk.text": "Accessibility and Input Monitoring are enabled. Bocha Switcher is working.",
            "wizard.accessibility.title": "Step 1 of 2: Accessibility",
            "wizard.accessibility.text": "Bocha Switcher needs Accessibility permission.\n\nSettings will open — add Bocha Switcher.\nThe app will detect it automatically.",
            "wizard.inputMonitoring.title": "Step 2 of 2: Input Monitoring",
            "wizard.inputMonitoring.text": "Now Input Monitoring permission is needed.\n\n⚠️ macOS will require an app restart after adding.\nBocha Switcher will restart automatically.",
            "wizard.openSettings": "Open Settings",
            "wizard.later": "Later",
            "wizard.launchAtLogin.title": "Launch at Login",
            "wizard.launchAtLogin.text": "Would you like Bocha Switcher to start automatically when you log in?\n\nYou can change this later in Settings.",
            "wizard.yes": "Yes",
            "wizard.no": "No",

            "settings.title": "Bocha Switcher — Settings",
            "settings.tab.general": "General",
            "settings.tab.advanced": "Advanced",
            "settings.autoSwitch": "Enable Bocha Switcher",
            "settings.trigger": "Trigger:",
            "settings.triggerRightOnly": "Right key only",
            "settings.triggerDoubleTap": "Double tap",
            "settings.triggerHint": "Tap the chosen key by itself, without other keys.",
            "menu.autoConvert": "Automatic conversion (beta)",
            "menu.keySound": "Layout sound (beta)",
            "menu.caretFlag": "Layout at cursor (beta)",
            "settings.switchHotkey": "Layout switch hotkey",
            "settings.caseHotkey": "Change-case hotkey",
            "settings.switchHotkey.off": "Off",
            "settings.switchHotkey.busy": " — already in use",
            "settings.caretFlag": "Show layout (RU/EN) at the text cursor (beta)",
            "settings.caretFlag.hint": "Briefly shows the current layout next to the text cursor after a switch. Not available in all apps.",
            "menu.remoteDesktop": "Remote Desktop mode (beta)",
            "settings.autoConvert": "Automatic conversion (beta)",
            "settings.autoConvert.hint": "Detects words typed in the wrong layout and converts them automatically. Off by default.",
            "onboard.autoConvert.title": "Automatic layout conversion",
            "onboard.autoConvert.text": "Bocha Switcher can fix the keyboard layout automatically as you type. It's off by default. The manual trigger (Option) always works and undoes a fix. Enable automatic conversion now?",
            "settings.tab.exceptions": "Auto-conversion",
            "settings.remoteDesktop.hint": "For Apple Screen Sharing: run Bocha Switcher on the remote Mac too and enable this on both.",
            "settings.exceptions.apps": "Don’t auto-convert in these apps",
            "settings.exceptions.never": "Never convert these words",
            "settings.exceptions.always": "Always convert these words",
            "settings.exceptions.addWordPrompt": "Enter a word:",
            "common.add": "Add",
            "common.cancel": "Cancel",
            "learn.question": "Always leave “%@” unchanged?",
            "learn.add": "Add to exceptions",
            "learn.notNow": "Not now",
            "settings.launchAtLogin": "Launch at login",
            "settings.checkUpdates": "Check for updates automatically",
            "settings.checkUpdates.hint": "Connects to GitHub on launch and periodically while running to look for new versions.",
            "settings.convertByText": "Convert selection by text (flip both scripts)",
            "settings.convertByText.hint": "When on, the trigger flips the entire selection between scripts (Latin ↔ Cyrillic), ignoring the active layout. Off: each word is fixed smartly and correct text is kept.",
            "settings.convertWholeLine": "Trigger converts the whole line (not just the last word)",
            "settings.convertWholeLine.hint": "The trigger selects the current line up to the cursor and converts it (fixing only the mis-typed words). Handy in terminals and when several words are typed in the wrong layout. Off: only the last word is converted.",
            "settings.smartConversion": "Smart selection conversion",
            "settings.smartConversion.hint": "Fixes only the mis-typed words in a selection and keeps text that is already correct (e.g. «iPhone стоит»). Off: the whole selection is flipped one way by the current layout.",
            "settings.layout1": "Layout 1:",
            "settings.layout2": "Layout 2:",
            "settings.autoDetect": "Auto-detect",
            "settings.debugLog": "Debug logging",
            "settings.secureNotice": "Show the Secure Input notice",
            "settings.showLog": "Show Log File",
            "settings.sendLog": "Send Log",
            "settings.hotkey": "Tap the trigger key alone — converts the last word (or selected text). Double tap — reverse.",
            "settings.language": "Interface language:",
            "settings.languageAuto": "System default",
            "settings.perAppLayout": "Remember layout per application",

            "update.available": "Update Available",
            "update.beta": "(beta)",
            "secure.paused.title": "Bocha Switcher is paused",
            "secure.paused.body": "Secure Input is active — it’s held by %@. Bocha Switcher isn’t touching your keystrokes (it never reads what you type there). Switch away from that app, or turn off its “Secure Keyboard Entry”, to resume.",
            "secure.paused.unknownapp": "another app",
            "update.newVersion": "New version:",
            "update.download": "Download",
            "update.installRestart": "Install & Restart",
            "update.skip": "Skip",
            "update.later": "Later",
            "update.upToDate": "Up to Date",
            "update.latestInstalled": "You have the latest version installed.",
            "update.checkFailed": "Update Check Failed",
            "update.checkFailedDetail": "Could not connect to the update server. Please check your internet connection.",
            "update.installFailed": "Installation Failed",
            "update.downloadCorrupted": "The downloaded file is corrupted — the network may have interrupted or altered the download. Try downloading in your browser.",
            "update.integrityFailed": "Update authenticity check failed. Installation cancelled.",
            "update.downloadFailed": "Could not download the update. Please check your internet connection.",
        ],

        // ========== РУССКИЙ ==========
        "ru": [
            "menu.autoSwitch": "Включить Bocha Switcher",
            "menu.checkPermissions": "Проверить разрешения…",
            "menu.settings": "Настройки…",
            "menu.checkUpdates": "Проверить обновления…",
            "menu.projectPage": "Страница проекта",
            "whatsnew.title": "Что нового в Bocha Switcher",
            "whatsnew.body": "Исправления и улучшения.",
            "whatsnew.more": "Подробнее на GitHub",
            "menu.quit": "Выход",

            "wizard.permissionsReset.title": "Разрешения сброшены после обновления",
            "wizard.permissionsReset.text": "macOS сбросил разрешения из-за обновления программы.\n\nBocha Switcher удалит старые записи и запросит разрешения заново.\nВам нужно только включить переключатели.",
            "wizard.permissionsOk.title": "Все разрешения на месте",
            "wizard.permissionsOk.text": "«Универсальный доступ» и «Мониторинг ввода» включены. Bocha Switcher работает.",
            "wizard.accessibility.title": "Шаг 1 из 2: Универсальный доступ",
            "wizard.accessibility.text": "Bocha Switcher нужно разрешение «Универсальный доступ».\n\nОткроются настройки — добавьте Bocha Switcher.\nПрограмма определит автоматически.",
            "wizard.inputMonitoring.title": "Шаг 2 из 2: Мониторинг ввода",
            "wizard.inputMonitoring.text": "Теперь нужно разрешение «Мониторинг ввода».\n\n⚠️ macOS потребует перезапуск приложения.\nBocha Switcher перезапустится автоматически.",
            "wizard.openSettings": "Открыть настройки",
            "wizard.later": "Позже",
            "wizard.launchAtLogin.title": "Автозагрузка",
            "wizard.launchAtLogin.text": "Запускать Bocha Switcher автоматически при входе в систему?\n\nЭто можно изменить позже в Настройках.",
            "wizard.yes": "Да",
            "wizard.no": "Нет",

            "settings.title": "Bocha Switcher — Настройки",
            "settings.tab.general": "Основные",
            "settings.tab.advanced": "Расширенные",
            "settings.autoSwitch": "Включить Bocha Switcher",
            "settings.trigger": "Триггер:",
            "settings.triggerRightOnly": "Только правая клавиша",
            "settings.triggerDoubleTap": "Двойной тап",
            "settings.triggerHint": "Нажимайте выбранную клавишу отдельно, без других клавиш.",
            "menu.autoConvert": "Автоматическая конверсия (бета)",
            "menu.keySound": "Звук раскладки (бета)",
            "menu.caretFlag": "Раскладка у курсора (бета)",
            "settings.switchHotkey": "Хоткей смены раскладки",
            "settings.caseHotkey": "Хоткей смены регистра",
            "settings.switchHotkey.off": "Выключен",
            "settings.switchHotkey.busy": " — уже используется",
            "settings.caretFlag": "Показывать раскладку (RU/EN) у курсора (бета)",
            "settings.caretFlag.hint": "После переключения ненадолго показывает раскладку рядом с курсором. Доступно не во всех приложениях.",
            "menu.remoteDesktop": "Режим удалённого рабочего стола (бета)",
            "settings.autoConvert": "Автоматическая конверсия (бета)",
            "settings.autoConvert.hint": "Определяет слова в неправильной раскладке и конвертирует их сама. По умолчанию выкл.",
            "onboard.autoConvert.title": "Автоматическая конверсия раскладки",
            "onboard.autoConvert.text": "Bocha Switcher может исправлять раскладку автоматически по ходу набора. По умолчанию выключено. Ручной триггер (Option) всегда работает — им же отменяется замена. Включить автоматическую конверсию сейчас?",
            "settings.tab.exceptions": "Автоконверсия",
            "settings.remoteDesktop.hint": "Для Apple Screen Sharing: запустите Bocha Switcher и на удалённом Mac, включив этот режим на обоих.",
            "settings.exceptions.apps": "Не конвертировать в этих приложениях",
            "settings.exceptions.never": "Никогда не конвертировать эти слова",
            "settings.exceptions.always": "Всегда конвертировать эти слова",
            "settings.exceptions.addWordPrompt": "Введите слово:",
            "common.add": "Добавить",
            "common.cancel": "Отмена",
            "learn.question": "Всегда оставлять «%@» без замены?",
            "learn.add": "Добавить в исключения",
            "learn.notNow": "Не сейчас",
            "settings.launchAtLogin": "Запускать при входе",
            "settings.checkUpdates": "Автоматически проверять обновления",
            "settings.checkUpdates.hint": "Обращается к GitHub при запуске и периодически, пока приложение работает, чтобы узнать о новой версии.",
            "settings.convertByText": "Конвертировать выделение по тексту (флип обеих раскладок)",
            "settings.convertByText.hint": "Когда включено, триггер переворачивает всё выделение между письменностями (латиница ↔ кириллица) независимо от активной раскладки. Выключено: каждое слово чинится умно, а верный текст сохраняется.",
            "settings.convertWholeLine": "Триггер конвертирует всю строку (не только последнее слово)",
            "settings.convertWholeLine.hint": "Триггер сам выделяет строку до курсора и конвертирует её (чинит только слова не в той раскладке). Удобно в терминале и когда несколько слов набрано не в той раскладке. Выключено: конвертируется только последнее слово.",
            "settings.smartConversion": "Умная конверсия выделения",
            "settings.smartConversion.hint": "Исправляет в выделении только слова не в той раскладке, а верный текст оставляет (напр. «iPhone стоит»). Выключено: всё выделение переворачивается в одну сторону по текущей раскладке.",
            "settings.layout1": "Раскладка 1:",
            "settings.layout2": "Раскладка 2:",
            "settings.autoDetect": "Автоопределение",
            "settings.debugLog": "Режим отладки",
            "settings.secureNotice": "Показывать подсказку о защищённом вводе",
            "settings.showLog": "Показать файл лога",
            "settings.sendLog": "Отправить лог",
            "settings.hotkey": "Тап клавиши-триггера — конвертирует последнее слово (или выделенный текст). Двойной тап — обратно.",
            "settings.language": "Язык интерфейса:",
            "settings.languageAuto": "Системный",
            "settings.perAppLayout": "Запоминать раскладку для каждого приложения",

            "update.available": "Доступно обновление",
            "update.beta": "(бета)",
            "secure.paused.title": "Bocha Switcher на паузе",
            "secure.paused.body": "Защищённый ввод активен — его удерживает %@. Bocha Switcher не трогает ваши клавиши (и никогда не читает, что вы там печатаете). Переключитесь из этого приложения или отключите в нём «Защищённый ввод», чтобы продолжить.",
            "secure.paused.unknownapp": "другое приложение",
            "update.newVersion": "Новая версия:",
            "update.download": "Скачать",
            "update.installRestart": "Установить и перезапустить",
            "update.skip": "Пропустить",
            "update.later": "Позже",
            "update.upToDate": "Актуальная версия",
            "update.latestInstalled": "У вас установлена последняя версия.",
            "update.checkFailed": "Ошибка проверки",
            "update.checkFailedDetail": "Не удалось подключиться к серверу обновлений. Проверьте подключение к интернету.",
            "update.installFailed": "Ошибка установки",
            "update.downloadCorrupted": "Загруженный файл повреждён — сеть могла оборвать или исказить загрузку. Попробуйте скачать в браузере.",
            "update.integrityFailed": "Проверка подлинности обновления не пройдена. Установка отменена.",
            "update.downloadFailed": "Не удалось скачать обновление. Проверьте подключение к интернету.",
        ],
    ]
}
