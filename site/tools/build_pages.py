#!/usr/bin/env python3
"""Source of the bochaswitcher.com pages (EN + RU).

Edit the texts here, then regenerate the static HTML that gets deployed:
    python3 site/tools/build_pages.py site/public
styles.css, app.js and assets/ in site/public are edited by hand.
"""
import html, json, os, sys

OUT = sys.argv[1]
SITE = "https://bochaswitcher.com"
GH = "https://github.com/dbocha/bocha_switcher"
VOICE = "https://bochavoice.com/"
LASTMOD = "2026-10-04"

def attr(obj):
    return html.escape(json.dumps(obj, ensure_ascii=False), quote=True)

T = {
 "en": dict(
  lang="en", locale="en_US", prefix="",
  title="Bocha Switcher — free keyboard layout switcher for Mac",
  desc="Fixes text typed in the wrong keyboard layout on Mac: ghbdtn → привет with one tap of ⌥. Free, open source, a Punto Switcher alternative for macOS.",
  og_alt="Bocha Switcher — Wrong layout? One tap fixes it. ghbdtn → привет. Free for Mac.",
  skip="Skip to content", nav_how="How it works", nav_features="Features", nav_faq="FAQ", nav_download="Download",
  privacy="Privacy", home="← Home", github="Source code",
  flag_b="Free", flag="No account, no ads, nothing leaves your Mac",
  h1='Wrong layout?<br><span class="accent">One tap fixes it.</span>',
  lead="Bocha Switcher lives in your Mac’s menu bar and fixes words typed in the wrong keyboard layout. Typed <i>ghbdtn</i> instead of <i>привет</i>? Tap <b>⌥</b> — the word is retyped correctly and the layout switches for you.",
  cta="Download for Mac", cta2="See how it works",
  note=["macOS 13+", "Apple Silicon and Intel", "Free, open source"],
  demo=dict(wrong="Ghbdtn", right="Привет", tail="! Да, давай в 10", **{"from": "EN", "to": "RU"},
            idle="Waiting for you to type", typing="English layout is on", noticed="Oops — wrong layout",
            tap="Tap ⌥", fixed="Fixed · layout switched to RU"),
  mb=["File", "Edit"], replay="Replay",
  demo_aria="Demo: a word typed in the English layout is fixed into Russian with one tap of the Option key.",
  how_eyebrow="How it works", how_h2="Type first. Fix with one key.",
  how_lead="No window to open and nothing to learn. The app waits in the menu bar and answers to the Option key.",
  flow=[("Type as usual", "Forgot to switch the layout? Keep going — the app quietly remembers the last word you typed."),
        ('Tap <span class="shortcut"><span>⌥</span></span>', "Press Option on its own, without other keys. The word is retyped in the other layout, and the layout switches so you can keep typing."),
        ("Tap twice to undo", "Changed your mind? A double tap puts the word back. Prefer another key? Choose Command, Control, Shift or a combination in settings.")],
  feat_eyebrow="More than one word", feat_h2="Fixes whatever came out wrong.",
  feat_lead="The basics take one key. Everything else is in settings, off until you want it.",
  features=[
    ("A selection or a line", "Select a sentence and tap ⌥: only the mistyped words change, so “iPhone стоит” stays as it is. In terminals, fix the whole line at once.", '<s>Rfr ltkf</s><i>→</i><b>Как дела</b>', None),
    ("Automatic mode", "Catches words typed in the wrong layout as you type, using the macOS spelling dictionary. ⌥ undoes any fix, and you can add exceptions for apps and words.", '<s>ntrcn</s><i>→</i><b>текст</b>', "Beta"),
    ("Case in one tap", "A separate hotkey cycles the last word or a selection through UPPER, lower and Title case. For when Caps Lock got you.", '<s>ПРИВЕТ</s><i>→</i><b>Привет</b>', None),
    ("Remembers per app", "Chats in Russian, the code editor in English: the app can keep a layout for each application and switch it when you change windows.", '<b>Telegram</b><i>→</i><b>RU</b>', None),
  ],
  priv_eyebrow="Privacy", priv_h2="What you type stays on your Mac.",
  priv_p="To fix a word the app only needs your last few keystrokes, and it keeps them in memory — nowhere else. There is no account, no analytics and no server of ours.",
  facts=["Nothing you type is saved or sent anywhere.",
         "No account, no ads, no telemetry.",
         "The only network request checks GitHub for updates, at most once a day. You can turn it off.",
         "Password fields are off-limits: while macOS secure input is on, the app sees no keys at all.",
         "The code is open under the MIT licence — read it on GitHub."],
  pill="Free · Open source", orbit="Keystrokes never leave this Mac",
  setup_eyebrow="Setup", setup_h2="Two minutes to set up.", setup_lead="One download and two permissions stand between you and your first fixed word.",
  setup=[("Install the app", "Open the DMG and drag Bocha Switcher into Applications. The first time, allow it in System Settings → Privacy & Security → Open Anyway."),
         ("Allow two permissions", "Accessibility to retype the word, Input Monitoring to notice it. The app opens the right settings pages and walks you through both."),
         ("Tap ⌥", "Type a word in the wrong layout anywhere and tap Option. New versions install from the menu bar, and the permissions stay.")],
  setup_link="Step-by-step instructions",
  faq_h2="Fair questions.", faq_lead="What people ask before installing an app that watches the keyboard.",
  faq=[
    ("Is it really free?", ["Yes. No account, no subscription, no ads and no in-app purchases. The code is open under the MIT licence."]),
    ("Which Macs are supported?", ["macOS 13 Ventura or newer, on Apple Silicon and Intel Macs."]),
    ("Why does macOS warn me when I open it?", ["The app is signed with our own certificate but not notarized by Apple, so macOS asks once before the first launch. Allow it in System Settings → Privacy & Security → Open Anyway — only if you trust the source.", "Updates install from the app’s menu and don’t trigger the warning again."]),
    ("Which layouts does it work with?", ["It is built for Russian and English. In settings you can choose any two keyboard layouts installed on your Mac."]),
    ("Where does it work?", ["In ordinary text fields of most apps: browsers, messengers, notes, mail, code editors and terminals. In password fields it stays silent on purpose."]),
    ("Can it fix words automatically?", ["Yes — turn on Automatic conversion in the menu. It is off by default because guessing is sometimes wrong; ⌥ undoes any automatic fix, and you can add exceptions."]),
    ("Is it a Punto Switcher alternative for Mac?", ["Yes. It does the same job on macOS: fixes words typed in the wrong layout with a key or automatically, and switches the layout for you. It is free and open source."]),
    ("I already use Punto Switcher or a similar app.", ["Quit it before starting Bocha Switcher. Two apps listening to the same key will fight over it."]),
    ("Who made it?", [f'The makers of <a class="text-link" href="{VOICE}">Bocha Voice</a> — free local dictation for Mac.']),
  ],
  final_lead="That’s “bocha” typed in the Russian layout. It happens to everyone — now it takes one tap to fix.",
  family="From the makers of Bocha Voice",
  dl_desc="Download Bocha Switcher for Mac: a free DMG for macOS 13+ on Apple Silicon and Intel. Fix text typed in the wrong layout with one key.",
  dl_title="Download Bocha Switcher", dl_lead="Free, for macOS 13 or newer on Apple Silicon and Intel Macs. About 1 MB.",
  dl_box_h="Bocha Switcher for Mac", dl_meta="Latest version", dl_btn="Download .dmg", dl_version="Version %s",
  sha="SHA-256 of the DMG", copy="Copy", copied="Copied",
  steps=[("Move it to Applications", "Open the DMG and drag Bocha Switcher onto the Applications folder. Launch it from there rather than from the disk image."),
         ("Allow the first launch", "The app is signed with our own certificate but not notarized by Apple, so macOS asks first. Close the warning, open System Settings → Privacy & Security, scroll to Security and choose Open Anyway — only if you trust this source."),
         ("Grant two permissions", "The app asks for Accessibility and Input Monitoring and opens the right settings pages. Turn Bocha Switcher on in both. After Input Monitoring macOS restarts the app — that is expected."),
         ("Tap ⌥", "Type ghbdtn anywhere and tap Option on its own. Settings live behind the RU/EN icon in the menu bar.")],
  callout_h="Updates", callout_p="New versions install from the menu: Check for Updates… → Install and Restart. Before replacing itself the app checks the checksum and our signature, and your permissions stay. Using Punto Switcher or a similar app? Quit it first.",
  dl_foot=f'Source code and all releases: <a class="text-link" href="{GH}">github.com/dbocha/bocha_switcher</a>',
  pv_title="Privacy", pv_updated="Last updated 4 October 2026",
  pv=[("Your typing stays on the Mac", ["To fix a word, Bocha Switcher keeps your last few keystrokes in memory. It does not save what you type, keep a history or send anything to us — there is no server of ours to send it to, and no account."]),
      ("The clipboard", ["Some conversions — of a selection, for example — briefly use the clipboard and restore its previous contents afterwards."]),
      ("Permissions", ["Accessibility is used to read and replace the word or selection you are fixing. Input Monitoring is used to see keystrokes and the trigger key. While macOS secure input is on — in password fields, for instance — the app receives no keys."]),
      ("Updates", ["Unless you turn it off, the app checks GitHub for a new version at most once a day. GitHub receives ordinary network data such as your IP address. Updates are downloaded from GitHub Releases and verified by checksum and signature before they are installed."]),
      ("Data on your device", ["Settings and your exception lists are stored on your Mac. An optional debug log, off by default, records technical events and word lengths, not the words."]),
      ("This website", ["The site sets no cookies of its own and has no advertising or analytics scripts. The download comes from GitHub Releases. Our hosting provider, Cloudflare, processes ordinary technical data such as IP address and user agent to deliver the page and protect it from abuse."])],
  nf_title="Page not found", nf_p="This page doesn’t exist. Maybe it was typed in the wrong layout.",
 ),
 "ru": dict(
  lang="ru", locale="ru_RU", prefix="/ru",
  title="Bocha Switcher — бесплатный переключатель раскладки для Mac",
  desc="Исправляет текст, набранный не в той раскладке: ghbdtn → привет одним нажатием ⌥. Бесплатный аналог Punto Switcher для macOS с открытым кодом.",
  og_alt="Bocha Switcher — Не та раскладка? Исправит одно нажатие. ghbdtn → привет. Бесплатно для Mac.",
  skip="Перейти к содержимому", nav_how="Как работает", nav_features="Возможности", nav_faq="Вопросы", nav_download="Скачать",
  privacy="Приватность", home="← На главную", github="Исходный код",
  flag_b="Бесплатно", flag="Без аккаунта и рекламы, ничего не уходит с Mac",
  h1='Не та раскладка?<br><span class="accent">Исправит одно нажатие.</span>',
  lead="Bocha Switcher живёт в строке меню Mac и исправляет слова, набранные не в той раскладке. Набрали <i>ghbdtn</i> вместо <i>привет</i>? Нажмите <b>⌥</b> — слово перепечатается правильно, а раскладка переключится сама.",
  cta="Скачать для Mac", cta2="Как это работает",
  note=["macOS 13+", "Apple Silicon и Intel", "Бесплатно, открытый код"],
  demo=dict(wrong="Ghbdtn", right="Привет", tail="! Да, давай в 10", **{"from": "EN", "to": "RU"},
            idle="Ждём набора", typing="Включена английская раскладка", noticed="Упс — не та раскладка",
            tap="Нажмите ⌥", fixed="Исправлено · раскладка RU"),
  mb=["Файл", "Правка"], replay="Ещё раз",
  demo_aria="Демо: слово, набранное в английской раскладке, исправляется на русское одним нажатием Option.",
  how_eyebrow="Как это работает", how_h2="Печатайте как привыкли. Исправляйте одной клавишей.",
  how_lead="Никаких окон и обучения. Приложение ждёт в строке меню и откликается на клавишу Option.",
  flow=[("Печатайте как обычно", "Забыли переключить раскладку? Ничего страшного: приложение запоминает последнее набранное слово."),
        ('Нажмите <span class="shortcut"><span>⌥</span></span>', "Нажмите Option отдельно, без других клавиш. Слово перепечатается в другой раскладке, а раскладка переключится — можно печатать дальше."),
        ("Дважды — отмена", "Передумали? Двойное нажатие вернёт слово как было. Удобнее другая клавиша? В настройках можно выбрать Command, Control, Shift или сочетание.")],
  feat_eyebrow="Больше, чем одно слово", feat_h2="Исправляет всё, что набралось не так.",
  feat_lead="Основное — одна клавиша. Остальное в настройках и выключено, пока не понадобится.",
  features=[
    ("Выделение или строка", "Выделите фразу и нажмите ⌥: поменяются только слова не в той раскладке, а «iPhone стоит» останется как есть. В терминале можно исправить всю строку сразу.", '<s>Rfr ltkf</s><i>→</i><b>Как дела</b>', None),
    ("Автоматический режим", "Ловит слова не в той раскладке прямо во время набора — по системному словарю macOS. ⌥ отменяет любое исправление, а для приложений и слов есть исключения.", '<s>ntrcn</s><i>→</i><b>текст</b>', "Бета"),
    ("Регистр одним нажатием", "Отдельная клавиша переключает последнее слово или выделение: ВЕРХНИЙ, нижний, С заглавной. Для случаев, когда подвёл Caps Lock.", '<s>ПРИВЕТ</s><i>→</i><b>Привет</b>', None),
    ("Раскладка для каждого приложения", "В чатах русский, в редакторе кода английский: приложение может помнить раскладку для каждой программы и переключать её при смене окна.", '<b>Telegram</b><i>→</i><b>RU</b>', None),
  ],
  priv_eyebrow="Приватность", priv_h2="То, что вы печатаете, остаётся на Mac.",
  priv_p="Чтобы исправить слово, приложению нужны только последние нажатия клавиш, и оно держит их в памяти — больше нигде. Нет ни аккаунта, ни аналитики, ни нашего сервера.",
  facts=["Набранный текст нигде не сохраняется и никуда не отправляется.",
         "Без аккаунта, рекламы и телеметрии.",
         "Единственный сетевой запрос — проверка обновлений на GitHub, не чаще раза в сутки. Её можно выключить.",
         "Поля паролей не трогаем: пока в macOS включён защищённый ввод, приложение не видит клавиш вообще.",
         "Код открыт под лицензией MIT — его можно прочитать на GitHub."],
  pill="Бесплатно · Открытый код", orbit="Нажатия клавиш не покидают этот Mac",
  setup_eyebrow="Установка", setup_h2="Две минуты на установку.", setup_lead="Одна загрузка и два разрешения — и первое слово исправлено.",
  setup=[("Установите приложение", "Откройте DMG и перетащите Bocha Switcher в «Программы». При первом запуске разрешите его в «Системные настройки → Конфиденциальность и безопасность → Всё равно открыть»."),
         ("Выдайте два разрешения", "«Универсальный доступ» — чтобы перепечатать слово, «Мониторинг ввода» — чтобы его заметить. Приложение само откроет нужные настройки и проведёт по шагам."),
         ("Нажмите ⌥", "Наберите слово не в той раскладке где угодно и нажмите Option. Новые версии ставятся из строки меню, разрешения сохраняются.")],
  setup_link="Пошаговая инструкция",
  faq_h2="Честные вопросы.", faq_lead="О чём спрашивают, прежде чем поставить приложение, которое следит за клавиатурой.",
  faq=[
    ("Это правда бесплатно?", ["Да. Без аккаунта, подписки, рекламы и встроенных покупок. Код открыт под лицензией MIT."]),
    ("Какие Mac поддерживаются?", ["macOS 13 Ventura и новее, на Mac с Apple Silicon и Intel."]),
    ("Почему macOS предупреждает при первом запуске?", ["Приложение подписано нашим сертификатом, но не нотаризовано Apple, поэтому macOS один раз спрашивает перед первым запуском. Разрешите его в «Системные настройки → Конфиденциальность и безопасность → Всё равно открыть» — только если доверяете источнику.", "Обновления ставятся из меню приложения и предупреждение больше не вызывают."]),
    ("С какими раскладками работает?", ["Оно сделано для русской и английской. В настройках можно выбрать любые две раскладки, установленные на Mac."]),
    ("Где работает?", ["В обычных текстовых полях большинства приложений: браузеры, мессенджеры, заметки, почта, редакторы кода и терминалы. В полях паролей оно намеренно молчит."]),
    ("Умеет исправлять автоматически?", ["Да — включите «Автоматическую конвертацию» в меню. По умолчанию она выключена, потому что угадывать иногда приходится неверно; ⌥ отменяет любое автоматическое исправление, а для слов и приложений есть исключения."]),
    ("Это аналог Punto Switcher для Mac?", ["Да. Он делает то же самое на macOS: исправляет слова, набранные не в той раскладке, по нажатию клавиши или автоматически и сам переключает раскладку. Бесплатно и с открытым кодом."]),
    ("У меня уже стоит Punto Switcher или похожее приложение.", ["Закройте его перед запуском Bocha Switcher: два приложения, которые слушают одну и ту же клавишу, будут мешать друг другу."]),
    ("Кто это сделал?", [f'Создатели <a class="text-link" href="{VOICE}">Bocha Voice</a> — бесплатной локальной диктовки для Mac.']),
  ],
  final_lead="Это «bocha», набранное в русской раскладке. Бывает с каждым — теперь исправляется одним нажатием.",
  family="От создателей Bocha Voice",
  dl_desc="Скачать Bocha Switcher для Mac: бесплатный DMG для macOS 13+ на Apple Silicon и Intel. Исправляйте текст не в той раскладке одной клавишей.",
  dl_title="Скачать Bocha Switcher", dl_lead="Бесплатно, для macOS 13 и новее на Mac с Apple Silicon и Intel. Около 1 МБ.",
  dl_box_h="Bocha Switcher для Mac", dl_meta="Последняя версия", dl_btn="Скачать .dmg", dl_version="Версия %s",
  sha="SHA-256 файла DMG", copy="Копировать", copied="Скопировано",
  steps=[("Перенесите в «Программы»", "Откройте DMG и перетащите Bocha Switcher в папку «Программы». Запускайте оттуда, а не из образа диска."),
         ("Разрешите первый запуск", "Приложение подписано нашим сертификатом, но не нотаризовано Apple, поэтому macOS сначала спросит. Закройте предупреждение, откройте «Системные настройки → Конфиденциальность и безопасность», пролистайте до раздела «Безопасность» и нажмите «Всё равно открыть» — только если доверяете источнику."),
         ("Выдайте два разрешения", "Приложение попросит «Универсальный доступ» и «Мониторинг ввода» и откроет нужные настройки. Включите Bocha Switcher в обоих. После «Мониторинга ввода» macOS перезапустит приложение — так и должно быть."),
         ("Нажмите ⌥", "Наберите где угодно ghbdtn и нажмите Option отдельно. Настройки — за значком RU/EN в строке меню.")],
  callout_h="Обновления", callout_p="Новые версии ставятся из меню: «Проверить обновления…» → «Установить и перезапустить». Перед заменой приложение проверяет контрольную сумму и нашу подпись, а разрешения сохраняются. Пользуетесь Punto Switcher или похожим приложением? Сначала закройте его.",
  dl_foot=f'Исходный код и все версии: <a class="text-link" href="{GH}">github.com/dbocha/bocha_switcher</a>',
  pv_title="Приватность", pv_updated="Обновлено 4 октября 2026",
  pv=[("Набранный текст остаётся на Mac", ["Чтобы исправить слово, Bocha Switcher держит в памяти последние нажатия клавиш. Он не сохраняет то, что вы печатаете, не ведёт историю и ничего нам не отправляет — нашего сервера, куда можно было бы отправить, нет, как и аккаунта."]),
      ("Буфер обмена", ["Некоторые исправления — например, выделенного текста — ненадолго используют буфер обмена и затем возвращают его прежнее содержимое."]),
      ("Разрешения", ["«Универсальный доступ» нужен, чтобы прочитать и заменить исправляемое слово или выделение. «Мониторинг ввода» — чтобы видеть нажатия клавиш и клавишу-триггер. Пока в macOS включён защищённый ввод — например, в поле пароля, — приложение не получает клавиш."]),
      ("Обновления", ["Если не выключить, приложение не чаще раза в сутки проверяет на GitHub, нет ли новой версии. GitHub получает обычные сетевые данные, например IP-адрес. Обновления скачиваются с GitHub Releases и перед установкой проверяются по контрольной сумме и подписи."]),
      ("Данные на устройстве", ["Настройки и списки исключений хранятся на вашем Mac. Отладочный журнал по умолчанию выключен; если его включить, он записывает технические события и длину слов, но не сами слова."]),
      ("Этот сайт", ["Сайт не ставит собственных cookie и не содержит рекламных или аналитических скриптов. Файл для скачивания отдаёт GitHub Releases. Наш хостинг-провайдер Cloudflare обрабатывает обычные технические данные — IP-адрес, user agent, — чтобы показать страницу и защитить её от злоупотреблений."])],
  nf_title="Страница не найдена", nf_p="Такой страницы нет. Возможно, её набрали не в той раскладке.",
 ),
}

def head(t, path, title=None, desc=None, ld=False, noindex=False):
    title = title or t["title"]; desc = desc or t["desc"]
    other = "ru" if t["lang"] == "en" else "en"
    en_url = SITE + path; ru_url = SITE + "/ru" + path
    canon = en_url if t["lang"] == "en" else ru_url
    return f'''<!doctype html>
<html lang="{t["lang"]}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{html.escape(title)}</title>
<meta name="description" content="{html.escape(desc)}">
<meta name="theme-color" content="#0f1216">
<meta name="color-scheme" content="dark">
<link rel="canonical" href="{canon}">
<link rel="alternate" hreflang="en" href="{en_url}">
<link rel="alternate" hreflang="ru" href="{ru_url}">
<link rel="alternate" hreflang="x-default" href="{en_url}">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Bocha Switcher">
<meta property="og:locale" content="{t["locale"]}">
<meta property="og:title" content="{html.escape(title)}">
<meta property="og:description" content="{html.escape(desc)}">
<meta property="og:url" content="{canon}">
<meta property="og:image" content="{SITE}/assets/og-{t["lang"]}.png">
<meta property="og:image:type" content="image/png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="{html.escape(t["og_alt"])}">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{html.escape(title)}">
<meta name="twitter:description" content="{html.escape(desc)}">
<meta name="twitter:image" content="{SITE}/assets/og-{t["lang"]}.png">
<meta name="twitter:image:alt" content="{html.escape(t["og_alt"])}">{robots(noindex)}{jsonld(t, canon) if ld else ""}
<link rel="icon" type="image/png" sizes="32x32" href="/assets/icon-32.png">
<link rel="apple-touch-icon" href="/assets/icon-180.png">
<link rel="stylesheet" href="/styles.css">
</head>
<body>
'''

def robots(noindex):
    return '\n<meta name="robots" content="noindex">' if noindex else ""

def jsonld(t, url):
    data = {
        "@context": "https://schema.org",
        "@type": "SoftwareApplication",
        "name": "Bocha Switcher",
        "url": url,
        "description": t["desc"],
        "inLanguage": t["lang"],
        "applicationCategory": "UtilitiesApplication",
        "operatingSystem": "macOS 13 or later",
        "downloadUrl": f"{SITE}/get",
        "image": f"{SITE}/assets/icon-512.png",
        "screenshot": f"{SITE}/assets/og-{t['lang']}.png",
        "isAccessibleForFree": True,
        "license": "https://opensource.org/licenses/MIT",
        "offers": {"@type": "Offer", "price": "0", "priceCurrency": "USD"},
    }
    return '\n<script type="application/ld+json">' + json.dumps(data, ensure_ascii=False) + "</script>"

def brand(t):
    return f'<a class="brand" href="{t["prefix"]}/" aria-label="Bocha Switcher"><img class="mark" src="/assets/icon-64.png" alt="" width="26" height="26"><span>Bocha Switcher</span></a>'

def header(t, path):
    p = t["prefix"]
    en_cur = ' aria-current="true"' if t["lang"] == "en" else ""
    ru_cur = ' aria-current="true"' if t["lang"] == "ru" else ""
    return f'''<a class="skip" href="#main">{t["skip"]}</a>
<header class="nav"><div class="wrap nav-inner">
  {brand(t)}
  <nav class="nav-links" aria-label="Main navigation">
    <a href="{p}/#how">{t["nav_how"]}</a>
    <a href="{p}/#features">{t["nav_features"]}</a>
    <a href="{p}/#faq">{t["nav_faq"]}</a>
  </nav>
  <div class="nav-side">
    <div class="lang"><a href="{path}" hreflang="en"{en_cur}>EN</a><a href="/ru{path}" hreflang="ru"{ru_cur}>RU</a></div>
    <a class="btn btn-primary btn-sm" href="{p}/download/">{t["nav_download"]}</a>
  </div>
</div></header>
'''

def footer(t):
    p = t["prefix"]
    return f'''<footer class="footer"><div class="wrap">
  <div class="footer-top">
    {brand(t)}
    <nav aria-label="Footer">
      <a href="{p}/#how">{t["nav_how"]}</a><a href="{p}/#faq">{t["nav_faq"]}</a><a href="{p}/download/">{t["nav_download"]}</a><a href="{p}/privacy/">{t["privacy"]}</a><a href="{GH}">{t["github"]}</a>
    </nav>
  </div>
  <div class="footer-bottom">
    <a class="family" href="{VOICE}">{t["family"]} →</a>
    <p>© 2026 Bocha Switcher</p>
  </div>
</div></footer>
<script src="/app.js" defer></script>
</body>
</html>
'''

def note(t):
    return '<span class="dot"></span>'.join(f'<span class="ni">{x}</span>' for x in t["note"])

def index(t):
    p = t["prefix"]; d = t["demo"]
    flow = "".join(f"<li><h3>{h}</h3><p>{x}</p></li>" for h, x in t["flow"])
    feats = "".join(
        f'<article class="card">' + (f'<div class="model-top"><span class="tag tag-soft">{tag}</span></div>' if tag else "")
        + f'<h3>{h}</h3><p>{x}</p><p class="swap">{sw}</p></article>'
        for h, x, sw, tag in t["features"])
    facts = "".join(f"<li>{f}</li>" for f in t["facts"])
    setup = "".join(f'<article class="card"><span class="num">0{i+1}</span><h3>{h}</h3><p>{x}</p></article>' for i, (h, x) in enumerate(t["setup"]))
    faq = "".join(f'<details><summary>{q}<span class="plus" aria-hidden="true"></span></summary>' + "".join(f"<p>{a}</p>" for a in ans) + "</details>" for q, ans in t["faq"])
    return head(t, "/", ld=True) + header(t, "/") + f'''<main id="main">

<section class="hero">
  <canvas class="vortex" aria-hidden="true"></canvas>
  <div class="wrap hero-copy">
    <a class="flag" href="#privacy"><b>{t["flag_b"]}</b><span>{t["flag"]}</span><i aria-hidden="true">→</i></a>
    <h1>{t["h1"]}</h1>
    <p class="lead">{t["lead"]}</p>
    <div class="actions">
      <a class="btn btn-primary" href="{p}/download/">{t["cta"]}</a>
      <a class="btn btn-ghost" href="#how">{t["cta2"]}</a>
    </div>
    <p class="note">{note(t)}</p>
  </div>

  <div class="wrap">
    <div class="stage" data-demo="{attr(d)}">
      <div class="menubar" aria-hidden="true">
        <span class="mb-items"><b>Telegram</b><span>{t["mb"][0]}</span><span>{t["mb"][1]}</span></span>
        <span class="mb-right"><span class="layout-badge">{d["from"]}</span><span class="mb-clock">9:41</span></span>
      </div>
      <div class="window">
        <div class="window-bar">
          <span class="traffic" aria-hidden="true"><i></i><i></i><i></i></span>
          <span class="window-title">Telegram — Маша</span>
          <button class="replay" type="button">{t["replay"]}</button>
        </div>
        <div class="window-body">
          <p class="chat-in">Созвонимся завтра утром?</p>
          <p class="doc-text"><span class="typed" data-typed></span><span data-tail></span><span class="caret" aria-hidden="true"></span></p>
        </div>
      </div>
      <div class="recorder" role="img" aria-label="{html.escape(t["demo_aria"])}">
        <span class="keys" aria-hidden="true"><kbd class="key trigger">⌥</kbd></span>
        <span class="status"><span data-label>{d["idle"]}</span></span>
      </div>
    </div>
  </div>
</section>

<section class="section tint" id="how">
  <div class="wrap">
    <div class="head center reveal">
      <span class="eyebrow">{t["how_eyebrow"]}</span>
      <h2>{t["how_h2"]}</h2>
      <p class="lead">{t["how_lead"]}</p>
    </div>
    <ol class="flow reveal">{flow}</ol>
  </div>
</section>

<section class="section" id="features">
  <div class="wrap">
    <div class="head reveal">
      <span class="eyebrow">{t["feat_eyebrow"]}</span>
      <h2>{t["feat_h2"]}</h2>
      <p class="lead">{t["feat_lead"]}</p>
    </div>
    <div class="grid grid-4 reveal">{feats}</div>
  </div>
</section>

<section class="section tint" id="privacy">
  <div class="wrap privacy-inner">
    <div class="privacy-copy reveal">
      <span class="eyebrow">{t["priv_eyebrow"]}</span>
      <h2>{t["priv_h2"]}</h2>
      <p>{t["priv_p"]}</p>
      <ul class="facts">{facts}</ul>
      <p class="pill"><img class="mark" src="/assets/icon-64.png" alt="" width="18" height="18">{t["pill"]}</p>
    </div>
    <div class="orbit reveal" aria-hidden="true">
      <svg viewBox="0 0 520 450">
        <defs><linearGradient id="orb" x1="0" y1="0" x2="520" y2="450" gradientUnits="userSpaceOnUse">
          <stop stop-color="#ff8a3d" stop-opacity=".55"/><stop offset=".55" stop-color="#ffb071" stop-opacity=".18"/><stop offset="1" stop-color="#ff8a3d" stop-opacity=".45"/>
        </linearGradient></defs>
        <g fill="none" stroke="url(#orb)">
          <ellipse cx="260" cy="225" rx="246" ry="150" stroke-width="1.2" transform="rotate(-12 260 225)"/>
          <ellipse cx="260" cy="225" rx="205" ry="196" stroke-width="1" opacity=".7" transform="rotate(14 260 225)"/>
          <ellipse cx="260" cy="225" rx="150" ry="216" stroke-width="1" opacity=".45" transform="rotate(-4 260 225)"/>
        </g>
      </svg>
      <span class="orbit-glow"></span>
      <div class="orbit-core">
        <span class="traffic"><i></i><i></i><i></i></span>
        <img src="/assets/icon-180.png" alt="" width="90" height="90" style="margin:6px auto 0">
        <p>{t["orbit"]}</p>
      </div>
    </div>
  </div>
</section>

<section class="section">
  <div class="wrap">
    <div class="head reveal">
      <span class="eyebrow">{t["setup_eyebrow"]}</span>
      <h2>{t["setup_h2"]}</h2>
      <p class="lead">{t["setup_lead"]}</p>
    </div>
    <div class="setup reveal">{setup}</div>
    <p class="after-grid reveal"><a class="text-link" href="{p}/download/">{t["setup_link"]}</a></p>
  </div>
</section>

<section class="section tint" id="faq">
  <div class="wrap faq-grid">
    <div class="head reveal" style="margin-bottom:0">
      <span class="eyebrow">{t["nav_faq"]}</span>
      <h2>{t["faq_h2"]}</h2>
      <p class="lead">{t["faq_lead"]}</p>
    </div>
    <div class="faq-list reveal">{faq}</div>
  </div>
</section>

<section class="final">
  <div class="wrap">
    <h2><span class="flip" data-flip="{attr(["ищсрф", "bocha"])}"><span data-flip-out>bocha</span></span></h2>
    <p class="lead">{t["final_lead"]}</p>
    <div class="actions"><a class="btn btn-primary" href="{p}/download/">{t["cta"]}</a></div>
    <p class="note">{note(t)}</p>
  </div>
</section>
</main>
''' + footer(t)

def download(t):
    steps = "".join(f"<li><h2>{h}</h2><p>{x}</p></li>" for h, x in t["steps"])
    rel = {"version": t["dl_version"]}
    return head(t, "/download/", title=f'{t["dl_title"]} для Mac' if t["lang"] == "ru" else f'{t["dl_title"]} for Mac', desc=t["dl_desc"]) + header(t, "/download/") + f'''<main id="main">

<section class="page"><div class="wrap">
  <a class="back" href="{t["prefix"]}/">{t["home"]}</a>
  <div class="page-head">
    <h1>{t["dl_title"]}</h1>
    <p class="lead">{t["dl_lead"]}</p>
  </div>

  <div class="download-box" data-state="ready" data-release="{attr(rel)}">
    <div class="app-id">
      <img class="app-icon" src="/assets/icon-180.png" alt="" width="72" height="72">
      <div>
        <h2>{t["dl_box_h"]}</h2>
        <p class="note" data-meta>{t["dl_meta"]}</p>
      </div>
    </div>
    <a class="btn btn-primary" href="/get">{t["dl_btn"]}</a>
  </div>

  <div class="checksum" hidden>
    <div class="checksum-head"><span>{t["sha"]}</span><button class="copy" type="button" data-copy="[data-checksum]" data-copied="{t["copied"]}">{t["copy"]}</button></div>
    <code data-checksum></code>
  </div>

  <ol class="steps-num">{steps}</ol>

  <div class="callout">
    <h2>{t["callout_h"]}</h2>
    <p>{t["callout_p"]}</p>
  </div>

  <p class="footnote">{t["dl_foot"]}</p>
</div></section>
</main>
''' + footer(t)

def privacy(t):
    body = "".join(f"<h2>{h}</h2>" + "".join(f"<p>{x}</p>" for x in ps) for h, ps in t["pv"])
    return head(t, "/privacy/", title=f'{t["pv_title"]} — Bocha Switcher') + header(t, "/privacy/") + f'''<main id="main">

<section class="page"><div class="wrap"><div class="prose">
  <a class="back" href="{t["prefix"]}/">{t["home"]}</a>
  <h1>{t["pv_title"]}</h1>
  <p class="updated">{t["pv_updated"]}</p>
  {body}
</div></div></section>
</main>
''' + footer(t)

def notfound():
    t = T["en"]; r = T["ru"]
    return head(t, "/", title="404 — Bocha Switcher", noindex=True) + header(t, "/") + f'''<main id="main">

<section class="page"><div class="wrap"><div class="prose">
  <h1>404</h1>
  <p class="lead">{t["nf_p"]}</p>
  <p class="lead">{r["nf_p"]}</p>
  <p><a class="text-link" href="/">{t["home"]}</a> · <a class="text-link" href="/ru/">{r["home"]}</a></p>
</div></div></section>
</main>
''' + footer(t)

def write(rel, text):
    path = os.path.join(OUT, rel)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write(text)

for lang, t in T.items():
    base = "" if lang == "en" else "ru/"
    write(base + "index.html", index(t))
    write(base + "download/index.html", download(t))
    write(base + "privacy/index.html", privacy(t))
write("404.html", notfound())
write("robots.txt", f"User-agent: *\nAllow: /\nSitemap: {SITE}/sitemap.xml\n")
urls = [f"{SITE}{pre}{p}" for pre in ("", "/ru") for p in ("/", "/download/", "/privacy/")]
write("sitemap.xml", '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
      + "".join(f"  <url><loc>{u}</loc><lastmod>{LASTMOD}</lastmod></url>\n" for u in urls) + "</urlset>\n")
print("ok")
