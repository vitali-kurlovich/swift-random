//
//  ContentControlConfigurationState.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 15.10.25.
//

import UIKit

extension UIConfigurationStateCustomKey {
    static let controlState = UIConfigurationStateCustomKey("key.ContentControlConfigurationState.state")

    static let controlTracking = UIConfigurationStateCustomKey("key.ContentControlConfigurationState.isTracking")

    static let controlTouchInside = UIConfigurationStateCustomKey("key.ContentControlConfigurationState.isTouchInside")

    // isTracking
}

struct ContentControlConfigurationState: UIConfigurationState, Hashable {
    var traitCollection: UITraitCollection

    private var keyValues: [UIConfigurationStateCustomKey: AnyHashable] = [:]

    init(traitCollection: UITraitCollection) {
        self.traitCollection = traitCollection
    }

    subscript(key: UIConfigurationStateCustomKey) -> AnyHashable? {
        get {
            keyValues[key]
        }
        set(newValue) {
            keyValues[key] = newValue
        }
    }

    var state: UIControl.State {
        get {
            let rawValue = self[.controlState] as? UInt ?? 0
            return .init(rawValue: rawValue)
        }
        set {
            self[.controlState] = newValue.rawValue
        }
    }

    var isTracking: Bool {
        get {
            self[.controlTracking] as? Bool ?? false
        }

        set {
            self[.controlTracking] = newValue
        }
    }

    var isTouchInside: Bool {
        get {
            self[.controlTouchInside] as? Bool ?? false
        }

        set {
            self[.controlTouchInside] = newValue
        }
    }

    //

    var isEnabled: Bool {
        !state.contains(.disabled)
    }

    var isSelected: Bool {
        state.contains(.selected)
    }

    var isHighlighted: Bool {
        state.contains(.highlighted)
    }

    var isFocused: Bool {
        state.contains(.focused)
    }
}
