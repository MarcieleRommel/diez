import UIKit

private var registeredFonts: Set<String> = []

private func registerFont(_ font: Font) {
    if font.file.src == "" || registeredFonts.contains(font.file.src) {
        return
    }

    registeredFonts.insert(font.file.src)

    guard
        let url = font.file.url,
        let data = try? Data(contentsOf: url) as CFData,
        let dataProvider = CGDataProvider(data: data),
        let cgFont = CGFont(dataProvider) else {
            return
    }

    CTFontManagerRegisterGraphicsFont(cgFont, nil)
}

extension Typograph {
    /**
     The `UIFont` of the `Typograph`.

     Iff `shouldScale` is `true`, the font will be scaled according to `UIFontMetric`s Dynamic Type scaling system with the `Typograph`s `iosTextStyle` value.

     This uses the `UIFont(name:size)` initializer and may return nil as a result.
     */
    @objc
    public var uiFont: UIFont? {
        return UIFont.from(typograph: self)
    }

    /**
     The `UIFont` of the `Typograph`.

     Iff `shouldScale` is `true`, the font will be scaled according to `UIFontMetric`s Dynamic Type scaling system with the `Typograph`s `iosTextStyle` value and the provided `UITraitCollection`.

     This uses the `UIFont(name:size)` initializer and may return nil as a result.
     */
    @objc(uiFontWithTraitCollection:)
    public func uiFont(for traitCollection: UITraitCollection) -> UIFont? {
        return UIFont.from(typograph: self, traitCollection: traitCollection)
    }

    /**
     `NSAttributedString` attributes of the `Typograph`.
     */
    @objc
    public var attributedStringAttributes: [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(color: color),
        ]

        if let font = uiFont {
            attributes[.font] = font
        }

        return attributes
    }

    /**
     Constructs an `NSAttributedString` decorating the provided `String`.
     */
    @objc(attributedStringDecoratingString:)
    public func attributedString(decorating string: String) -> NSAttributedString {
        return NSAttributedString(string: string, typograph: self)
    }

    /**
     The `UIFont.TextStyle` for the `Typograph`.
     */
    @objc
    public var uiFontTextStyle: UIFont.TextStyle {
        switch iosTextStyle {
        case "body": return .body
        case "callout": return .callout
        case "caption1": return .caption1
        case "caption2": return .caption2
        case "footnote": return .footnote
        case "headline": return .headline
        case "subheadline": return .subheadline
        case "largeTitle": return .largeTitle
        case "title1": return .title1
        case "title2": return .title2
        case "title3": return .title3
        default: return .body
        }
    }
}

extension UIFont {
    /**
     Constructs a `UIFont` with the provided `Typograph`.

     - Note: Some of the properties of the `Typograph` are not considered when constructing the `UIFont` (e.g. `.color`), so the resulting `UIFont` does not represent the complete `Typograph`.
     */
    @objc(dez_fontWithTypograph:traitCollection:)
    public static func from(typograph: Typograph, traitCollection: UITraitCollection? = nil) -> UIFont? {
        registerFont(typograph.font)

        guard let font = UIFont(name: typograph.font.name, size: typograph.fontSize) else {
            return nil
        }

        guard typograph.shouldScale else {
            return font
        }

        let metrics = UIFontMetrics(forTextStyle: typograph.uiFontTextStyle)

        guard let traitCollection = traitCollection else {
            return metrics.scaledFont(for: font)
        }

        return metrics.scaledFont(for: font, compatibleWith: traitCollection)
    }
}

extension NSAttributedString {
    /**
     - Tag: NSAttributedString.init

     Initializes an `NSAttributedString` with the provided string and `Typograph`.
     */
    @objc(dez_initWithString:typograph:)
    public convenience init(string: String, typograph: Typograph) {
        self.init(string: string, attributes: typograph.attributedStringAttributes)
    }

    /**
     - See [NSAttributedString(string: String, typograph: Typograph)](x-source-tag://NSAttributedString.init)
      */
    @objc(dez_stringWithString:typograph:)
    public static func from(string: String, typograph: Typograph) -> NSAttributedString {
        return NSAttributedString(string: string, typograph: typograph)
    }
}

extension UILabel {
    /**
     Applies the provided `Typograph` to the receiver.
     */
    @objc(dez_applyTypograph:withTraitCollection:)
    public func apply(_ typograph: Typograph, withTraitCollection traitCollection: UITraitCollection? = nil) {
        font = UIFont.from(typograph: typograph, traitCollection: traitCollection)
        textColor = UIColor(color: typograph.color)
        adjustsFontForContentSizeCategory = typograph.shouldScale
    }
}

extension UITextView {
    /**
     Applies the provided `Typograph` to the receiver.
     */
    @objc(dez_applyTypograph:withTraitCollection:)
    public func apply(_ typograph: Typograph, withTraitCollection traitCollection: UITraitCollection? = nil) {
        font = UIFont.from(typograph: typograph, traitCollection: traitCollection)
        textColor = UIColor(color: typograph.color)
        adjustsFontForContentSizeCategory = typograph.shouldScale
    }
}

extension UITextField {
    /**
     Applies the provided `Typograph` to the receiver.
     */
    @objc(dez_applyTypograph:withTraitCollection:)
    public func apply(_ typograph: Typograph, withTraitCollection traitCollection: UITraitCollection? = nil) {
        // Setting the default text attributes overrides text alignment.
        // Re-set the alignment after applying the style.
        let textAlignment = self.textAlignment
        defer {
            self.textAlignment = textAlignment
        }

        font = UIFont.from(typograph: typograph, traitCollection: traitCollection)
        textColor = UIColor(color: typograph.color)
        adjustsFontForContentSizeCategory = typograph.shouldScale
        defaultTextAttributes = typograph.attributedStringAttributes
    }
}
