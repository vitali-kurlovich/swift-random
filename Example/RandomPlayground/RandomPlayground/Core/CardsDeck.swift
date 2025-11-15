//
//  CardsDeck.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 2.10.25.
//

import Random

struct CardsDeck: Hashable {
    private var cards = Card.allCards
}

extension CardsDeck: Collection {
    typealias Element = Card
    typealias Index = Array<Card>.Index

    var startIndex: Index {
        cards.startIndex
    }

    var endIndex: Index {
        cards.endIndex
    }

    subscript(position: Index) -> Element {
        cards[position]
    }

    func index(after i: Index) -> Index {
        cards.index(after: i)
    }
}

extension CardsDeck {
    mutating func shuffle<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) where T: RandomNumberGenerator {
        cards.shuffle(algorithm: algorithm, using: &generator)
    }
}
