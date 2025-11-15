//
//  UUIDLabel.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 11.10.25.
//

import UIKit

class InteractionLabel: UILabel, UIEditMenuInteractionDelegate {
    override var canBecomeFirstResponder: Bool { true }

    private var editMenuInteraction: UIEditMenuInteraction?

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        prepareEditMenuInteraction()
    }

    override func copy(_: Any?) {
        // super.copy(sender)
    }

    override func paste(itemProviders _: [NSItemProvider]) {}

    override func paste(_: Any?) {}

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }

    func editMenuInteraction(_: UIEditMenuInteraction, menuFor _: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
//            let indentationMenu = UIMenu(title: "Indentation", image: UIImage(systemName: "list.bullet.indent"), children: [
//                UIAction(title: "Increase", image: UIImage(systemName: "increase.indent")) { (action) in
//                    // Increase indentation action.
//                    print("increase indent")
//                },
//                UIAction(title: "Decrease", image: UIImage(systemName: "decrease.indent")) { (action) in
//                    // Decrease indentation action.
//                    print("decrease indent")
//                }
//            ])
//
//
//            var actions = suggestedActions
//            actions.append(indentationMenu)
        return UIMenu(children: suggestedActions)
    }
}

private extension InteractionLabel {
    func prepareEditMenuInteraction() {
        guard editMenuInteraction == nil else { return }

        let interaction = UIEditMenuInteraction(delegate: self)
        addInteraction(interaction)
        editMenuInteraction = interaction

        prepareGesture()
    }

    func prepareGesture() {
        // Create the gesture recognizer.
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        longPress.allowedTouchTypes = [UITouch.TouchType.direct.rawValue as NSNumber]
        addGestureRecognizer(longPress)

        isUserInteractionEnabled = true
    }

    @objc func didLongPress(_ recognizer: UIGestureRecognizer) {
        guard let interaction = editMenuInteraction else { return }

        let location = recognizer.location(in: self)
        let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: location)

        // Present the edit menu interaction.
        interaction.presentEditMenu(with: configuration)
    }
}

final class UUIDLabel: UIView {
    var uuid: UUID? {
        didSet {}
    }

    private let label = InteractionLabel()

    var placeholder: String? {
        didSet {}
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        prepareLayout()
    }
}

extension UUIDLabel {
    var font: UIFont! {
        get {
            label.font
        }
        set {
            label.font = newValue
        }
    }

    var textColor: UIColor! {
        get {
            label.textColor
        }
        set {
            label.textColor = newValue
        }
    }
}

private extension UUIDLabel {
    func prepareLayout() {
        guard label.superview == nil else {
            return
        }

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "299993"

        addSubview(label)
        let constraints = [
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func contextMenuInteraction(
        _: UIContextMenuInteraction,
        configurationForMenuAtLocation _: CGPoint
    ) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(actionProvider: { suggestedActions in
            UIMenu(children: suggestedActions)
        })
    }
}


class CustomDrawView: UIView {
    
    override func layerWillDraw(_ layer: CALayer) {
        super.layerWillDraw(layer)
        debugPrint(#function)
    }
    
    override func draw(_ rect: CGRect, for formatter: UIViewPrintFormatter) {
        super.draw(rect, for: formatter)
        debugPrint(#function)
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        debugPrint(#function)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        debugPrint(#function)
    }
}

#Preview {
    let view = CustomDrawView(frame: .init(x: 0, y: 0, width: 120, height: 120))
    view.backgroundColor = .systemRed
    return view
}
