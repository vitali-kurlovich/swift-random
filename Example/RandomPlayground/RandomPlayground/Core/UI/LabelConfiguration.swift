//
//  LabelConfiguration.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 20.10.25.
//

import UIKit

struct LabelConfiguration: Hashable, UIContentConfiguration {
    var text: String? = nil
    var attributedText: NSAttributedString?

    var textProperties: TextProperties = .init()

    struct TextProperties: Hashable {
        var font: UIFont = .systemFont(ofSize: UIFont.labelFontSize)

        var color: UIColor = .label
        
        var textAlignment: NSTextAlignment = .natural

        var lineBreakMode: NSLineBreakMode = .byTruncatingTail

        var numberOfLines: Int = 1

        var adjustsFontSizeToFitWidth: Bool = false

        var minimumScaleFactor: CGFloat = 0.0

        var allowsDefaultTighteningForTruncation: Bool = false
    }

    func makeContentView() -> any UIView & UIContentView {
        let label = _LabelContent(frame: .zero, configuration: self)
        
        label.labelConfiguration = self
        label.sizeToFit()
        return label
    }

    func updated(for state: any UIConfigurationState) -> Self {
        
        var configuration = self
        
        if let state = state as? ContentControlConfigurationState {
            let color = configuration.textProperties.color
            
            if state.isHighlighted {
                configuration.textProperties.color = color.withProminence(.secondary)
            }
            
            if !state.isEnabled {
                configuration.textProperties.color = color.withProminence(.tertiary)
            }
            
            return configuration
        }
        
        return configuration
    }
}

private final class _LabelContent: UILabel, UIContentView {
    
    convenience init(frame: CGRect, configuration: LabelConfiguration) {
        self.init(frame: frame)
        self.labelConfiguration = configuration
    }
    
    var configuration: any UIContentConfiguration {
        get {
            labelConfiguration
        }
        set {
            guard let labelConfiguration = newValue as? LabelConfiguration else {
                fatalError("configuration reqiare \(String(describing: LabelConfiguration.self))")
            }
            
            self.labelConfiguration = labelConfiguration
        }
    }

   

    var labelConfiguration: LabelConfiguration {
        get {
            .init(text: text, attributedText: attributedText, textProperties: textProperties)
        }
        set {
            update(with: newValue)
        }
    }

    var textProperties: LabelConfiguration.TextProperties {
        get {
            LabelConfiguration.TextProperties(
                font: font,
                color: textColor,
                lineBreakMode: lineBreakMode,
                numberOfLines: numberOfLines,
                adjustsFontSizeToFitWidth: adjustsFontSizeToFitWidth,
                minimumScaleFactor: minimumScaleFactor,
                allowsDefaultTighteningForTruncation: allowsDefaultTighteningForTruncation
            )
        }
        set {
            update(with: newValue)
        }
    }

    func update(with configuration: LabelConfiguration) {
        text = configuration.text
        if let attr = configuration.attributedText {
            attributedText = attr
        }

        update(with: configuration.textProperties)
    }

    func update(with prop: LabelConfiguration.TextProperties) {
        font = prop.font
        textColor = prop.color
        lineBreakMode = prop.lineBreakMode
        numberOfLines = prop.numberOfLines
        adjustsFontSizeToFitWidth = prop.adjustsFontSizeToFitWidth
        minimumScaleFactor = prop.minimumScaleFactor
        allowsDefaultTighteningForTruncation = prop.allowsDefaultTighteningForTruncation
    }
}

#Preview {
    var configuration = LabelConfiguration()
    configuration.text = "Hello world"

   return configuration.makeContentView()
}
