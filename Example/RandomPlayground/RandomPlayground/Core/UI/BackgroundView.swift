//
//  BackgroundView.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 16.10.25.
//

import UIKit

final class BackgroundView: UIView {
    var background: UIBackgroundConfiguration = .clear() {
        didSet {
            guard oldValue != background else { return }
            invalidateBackgroundConfiguration()
        }
    }

    private lazy var backgroundView = makeBackgroundView()

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addSubview(backgroundView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = bounds
    }
}

private extension BackgroundView {
    func invalidateBackgroundConfiguration() {
        var configuration = UIContentUnavailableConfiguration.empty()
        configuration.background = background
        backgroundView.configuration = configuration
    }

    func makeBackgroundView() -> (UIView & UIContentView) {
        var configuration = UIContentUnavailableConfiguration.empty()
        configuration.background = background

        let contentView = configuration.makeContentView()
        contentView.isUserInteractionEnabled = false
        return contentView
    }
}
