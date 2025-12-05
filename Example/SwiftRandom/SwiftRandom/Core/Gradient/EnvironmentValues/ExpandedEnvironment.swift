//
//  ExpandedEnvironment.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 5.12.25.
//

import SwiftUI

private struct ExpandedEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var isExpanded: Bool {
        get { self[ExpandedEnvironmentKey.self] }
        set { self[ExpandedEnvironmentKey.self] = newValue }
    }
}
