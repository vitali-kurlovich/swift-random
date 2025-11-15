//
//  ContentConfigurationControl.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 14.10.25.
//

import UIKit

extension ContentControl {
    convenience init(frame: CGRect = .zero, contentConfiguration: ContentConfiguration) {
        self.init(frame: frame)
        self.contentConfiguration = contentConfiguration
    }
}

final class ContentControl<ContentConfiguration: UIContentConfiguration>: UIControl {
    typealias UpdateHandler = (ContentControl<ContentConfiguration>) -> Void

    private var logCount = 0
    
    func debugPrint(_ str: String ) {
        logCount += 1
        Swift.debugPrint("\(logCount): \(str)")
        
        
        UIResponder
        
    }
    
    var contentConfiguration: ContentConfiguration? {
        didSet {
            if let contentConfiguration {
                contentView.configuration = contentConfiguration
            }
        }
    }

    var updateConfigurationHandler: UpdateHandler?

    var backgroundConfiguration: UIBackgroundConfiguration {
        get {
            backgroundView.background
        }
        set {
            backgroundView.background = newValue
        }
    }

    private var needsUpdateConfiguration = true

    private lazy var contentView = makeContentView()
    private lazy var backgroundView = makeBackgroundView()

    func updateConfiguration(using state: ContentControlConfigurationState) {
        debugPrint("\(#function) isTracking: \(state.isTracking) isTouchInside: \(state.isTouchInside) state: \(state.state)")
       
    }

    // MARK: - Overrides

    override func layoutSubviews() {
        if needsUpdateConfiguration {
            updateConfigurationHandler?(self)
            updateConfiguration(using: configurationState)
            needsUpdateConfiguration = false
        }
        super.layoutSubviews()

        backgroundView.frame = bounds
    }

    override var isEnabled: Bool {
        didSet {
            guard oldValue != isEnabled else { return }
            setNeedsUpdateConfiguration()
        }
    }

    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return }
            setNeedsUpdateConfiguration()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            setNeedsUpdateConfiguration()
        }
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        prepareBackgroundViewLayout()
        prepareContentViewLayout()
    }
}

extension ContentControl {
    var configurationState: ContentControlConfigurationState {
        var contentState = ContentControlConfigurationState(traitCollection: traitCollection)

        contentState.state = state
        contentState.isTracking = isTracking
        contentState.isTouchInside = isTouchInside
        return contentState
    }

    func setNeedsUpdateConfiguration() {
        needsUpdateConfiguration = true
        setNeedsLayout()
    }
}

// MARK: - Private

private extension ContentControl {
    func makeContentView() -> UIView & UIContentView {
        guard let contentConfiguration else {
            fatalError("contentConfiguration must be not nil")
        }
        let contentView = contentConfiguration.makeContentView()
        contentView.configuration = contentConfiguration
        return contentView
    }

    func makeBackgroundView() -> BackgroundView {
        let backgroundView = BackgroundView(frame: bounds)
        backgroundView.isUserInteractionEnabled = false
        return backgroundView
    }

    func prepareContentViewLayout() {
        guard contentView.superview == nil else { return }

        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            contentView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func prepareBackgroundViewLayout() {
        guard backgroundView.superview == nil else { return }
        insertSubview(backgroundView, at: 0)
    }
}

#Preview {
    var configuration = LabelConfiguration()
    configuration.text = "Hello world"

    let view = ContentControl(contentConfiguration: configuration)

    view.updateConfigurationHandler = { control in
        var configuration = LabelConfiguration()
        configuration.text = "Hello world"
        
        control.contentConfiguration = configuration.updated(for: control.configurationState)
    }
    
    view.backgroundConfiguration.cornerRadius = 10
    view.backgroundConfiguration.backgroundColor = .orange
    
  //  view.isEnabled = false
    
    return view
}
