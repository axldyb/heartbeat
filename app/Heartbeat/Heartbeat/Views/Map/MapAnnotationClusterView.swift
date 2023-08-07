//
//  MapAnnotationClusterView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 16/04/2023.
//

import MapKit

class MapAnnotationClusterView: MKAnnotationView {

    private static let annotationSize = 32

    override var annotation: MKAnnotation? {
        willSet {
            guard let clusterAnnotation = newValue as? MKClusterAnnotation else {
                return
            }

            let mapAnnotations = clusterAnnotation.memberAnnotations.compactMap { $0 as? MapViewAnnotation }
            guard let mapAnnotation = mapAnnotations.first else {
                return
            }

            collisionMode = .circle

            let size = CGSize(width: Self.annotationSize, height: Self.annotationSize)
            image = drawGlyph(sized: size, colored: mapAnnotation.tintColor, withCount: mapAnnotations.count)
        }
    }

#if os(iOS)
    /**
     Draws the annotation's glyph.
     */
    private func drawGlyph(sized size: CGSize, colored tintColor: UIColor?, withCount count: Int) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            // draw background
            tintColor?.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height)).fill()

            if let image = UIImage(systemName: "\(count).circle")?.withTintColor(.white) {
                // draw glyph
                let imageRect = CGRect(x: size.width / 2 - image.size.width / 2,
                                       y: size.height / 2 - image.size.height / 2,
                                       width: image.size.width,
                                       height: image.size.height)
                image.draw(in: imageRect)
            } else {
                // draw text
                let fontSize: CGFloat = 24
                let textAttributes: [NSAttributedString.Key: NSObject] = [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)
                ]
                let text = "\(count)" as NSString
                let textSize = text.size(withAttributes: textAttributes)
                let textRect = CGRect(x: size.width / 2 - textSize.width / 2,
                                      y: size.height / 2 - textSize.height / 2,
                                      width: textSize.width,
                                      height: textSize.height)
                text.draw(in: textRect, withAttributes: textAttributes)
            }
        }
    }
#else
    /**
     Draws the annotation's glyph.
     */
    private func drawGlyph(sized size: CGSize, colored tintColor: NSColor?, withCount count: Int) -> NSImage {
        let image = NSImage(size: frame.size)

        guard let rep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(size.width),
            pixelsHigh: Int(size.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: NSColorSpaceName.calibratedRGB,
            bitmapFormat: .alphaFirst,
            bytesPerRow: 0,
            bitsPerPixel: 0
        ) else {
            return image
        }

        image.addRepresentation(rep)
        image.lockFocus()

        let context = NSGraphicsContext.current?.cgContext
        context?.saveGState()

        // draw background
        tintColor?.setFill()
        NSBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height)).fill()

        if let image = NSImage(systemSymbolName: "\(count).circle", accessibilityDescription: nil)?.withTintColor(NSColor.white) {
            // draw glyph
            let imageRect = CGRect(x: size.width / 2 - image.size.width / 2,
                                   y: size.height / 2 - image.size.height / 2,
                                   width: image.size.width,
                                   height: image.size.height)
            image.draw(in: imageRect)
        } else {
            // draw text
            let fontSize: CGFloat = 24
            let textAttributes: [NSAttributedString.Key: NSObject] = [
                NSAttributedString.Key.foregroundColor: NSColor.black,
                NSAttributedString.Key.font: NSFont.systemFont(ofSize: fontSize)
            ]
            let text = "\(count)" as NSString
            let textSize = text.size(withAttributes: textAttributes)
            let textRect = CGRect(x: size.width / 2 - textSize.width / 2,
                                  y: size.height / 2 - textSize.height / 2,
                                  width: textSize.width,
                                  height: textSize.height)
            text.draw(in: textRect, withAttributes: textAttributes)
        }

        image.unlockFocus()
        context?.restoreGState()

        return image
    }
#endif

}

#if os(macOS)
extension NSImage {

    func withTintColor(_ tintColor: NSColor) -> NSImage {
        guard let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil) else { return self }

        return NSImage(size: size, flipped: false) { bounds in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }

            tintColor.set()
            context.clip(to: bounds, mask: cgImage)
            context.fill(bounds)

            return true
        }
    }
}
#endif
