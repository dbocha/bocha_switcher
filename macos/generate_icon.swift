#!/usr/bin/env swift
// Генерирует иконку Bocha Switcher — оранжевая плашка с чёрным «EN/RU».
// Использование: swift generate_icon.swift <путь/к/BochaSwitcher.iconset>
// Дальше: iconutil -c icns <iconset> -o BochaSwitcher.icns (делает build_app.sh).

import AppKit

// Сетка macOS-иконки (Big Sur+): холст 1024, плашка 824 с отступом 100.
let canvas: CGFloat = 1024
let tile = NSRect(x: 100, y: 100, width: 824, height: 824)
let cornerRadius: CGFloat = 185

let orangeTop = NSColor(srgbRed: 1.00, green: 0.62, blue: 0.10, alpha: 1)
let orangeBottom = NSColor(srgbRed: 1.00, green: 0.48, blue: 0.00, alpha: 1)

func roundedFont(_ size: CGFloat) -> NSFont {
    let base = NSFont.systemFont(ofSize: size, weight: .heavy)
    guard let descriptor = base.fontDescriptor.withDesign(.rounded),
          let font = NSFont(descriptor: descriptor, size: size) else { return base }
    return font
}

/// Рисует строку так, чтобы центр её видимых глифов попал в `center`.
func drawCentered(_ text: String, at center: NSPoint, font: NSFont, in ctx: CGContext) {
    let attributed = NSAttributedString(string: text, attributes: [.font: font, .foregroundColor: NSColor.black])
    let line = CTLineCreateWithAttributedString(attributed)
    let bounds = CTLineGetBoundsWithOptions(line, .useGlyphPathBounds)
    ctx.textPosition = CGPoint(x: center.x - bounds.midX, y: center.y - bounds.midY)
    CTLineDraw(line, ctx)
}

func drawIcon(in ctx: CGContext) {
    let plate = NSBezierPath(roundedRect: tile, xRadius: cornerRadius, yRadius: cornerRadius)

    // Тень под плашкой, как у системных иконок
    NSGraphicsContext.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.28)
    shadow.shadowOffset = NSSize(width: 0, height: -10)
    shadow.shadowBlurRadius = 22
    shadow.set()
    orangeBottom.setFill()
    plate.fill()
    NSGraphicsContext.restoreGraphicsState()

    NSGradient(starting: orangeTop, ending: orangeBottom)!.draw(in: plate, angle: -90)

    // «EN» сверху слева, «RU» снизу справа, между ними — косая черта
    let font = roundedFont(250)
    drawCentered("EN", at: NSPoint(x: 370, y: 660), font: font, in: ctx)
    drawCentered("RU", at: NSPoint(x: 654, y: 364), font: font, in: ctx)

    let slash = NSBezierPath()
    slash.move(to: NSPoint(x: 330, y: 300))
    slash.line(to: NSPoint(x: 694, y: 724))
    slash.lineWidth = 44
    slash.lineCapStyle = .round
    NSColor.black.setStroke()
    slash.stroke()
}

func renderPNG(pixels: Int) -> Data {
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: pixels, pixelsHigh: pixels,
                               bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                               colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    rep.size = NSSize(width: canvas, height: canvas)   // рисуем в координатах 1024
    let context = NSGraphicsContext(bitmapImageRep: rep)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    drawIcon(in: context.cgContext)
    NSGraphicsContext.restoreGraphicsState()
    return rep.representation(using: .png, properties: [:])!
}

guard CommandLine.arguments.count == 2 else {
    FileHandle.standardError.write("usage: swift generate_icon.swift <output.iconset>\n".data(using: .utf8)!)
    exit(1)
}
let iconsetURL = URL(fileURLWithPath: CommandLine.arguments[1])
try FileManager.default.createDirectory(at: iconsetURL, withIntermediateDirectories: true)

for base in [16, 32, 128, 256, 512] {
    for scale in [1, 2] {
        let name = scale == 1 ? "icon_\(base)x\(base).png" : "icon_\(base)x\(base)@2x.png"
        try renderPNG(pixels: base * scale).write(to: iconsetURL.appendingPathComponent(name))
    }
}
print("Iconset written to \(iconsetURL.path)")
