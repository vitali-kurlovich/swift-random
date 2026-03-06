//
//  LineColorResolver.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

protocol LineColorResolver {
    associatedtype ID
    func resolveColor(for id: ID) -> Color
    func resolve(in environment: EnvironmentValues) -> Self
}

extension LineColorResolver {
    func resolve(in _: EnvironmentValues) -> Self {
        self
    }
}
