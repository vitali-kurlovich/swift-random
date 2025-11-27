//
//  LineStyle.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 26.11.25.
//

import SwiftUI

protocol LineStyle {
    associatedtype ID
    func resolveColor(for id: ID) -> Color
}
