//
//  FaroShuffleBarsModel.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 10.11.25.
//

import Foundation
import Observation
import Random

@Observable
final class FaroShuffleBarsModel {
    var seed: UUID = .init()
    var itemsCount: Int = 52
    var configuration: FaroShuffleConfiguration = .init(count: 3)
}

extension FaroShuffleBarsModel {
    var items: [BarItem] {
        var items = BarItem.fill(0 ..< itemsCount)

        var generator = MT19937RandomGenegator(uuid: seed)

        items.shuffle(algorithm: .faro(configuration), using: &generator)

        return items
    }
}
