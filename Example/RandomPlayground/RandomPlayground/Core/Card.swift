//
//  Card.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 2.10.25.
//

struct Card: Hashable {
    let suit: Suit
    let rank: Rank

    enum Suit: Hashable {
        case spade
        case heart
        case club
        case diamond
    }

    enum Rank: Hashable {
        case ace
        case `2`
        case `3`
        case `4`
        case `5`
        case `6`
        case `7`
        case `8`
        case `9`
        case `10`
        case jack
        case queen
        case king
    }
}

extension Card.Suit: CustomStringConvertible {
    var description: String {
        switch self {
        case .spade:
            "♤"
        case .heart:
            "♡"
        case .club:
            "♧"
        case .diamond:
            "♢"
        }
    }
}

extension Card.Rank: CustomStringConvertible {
    var description: String {
        switch self {
        case .ace:
            "A"
        case .`2`:
            "2"
        case .`3`:
            "3"
        case .`4`:
            "4"
        case .`5`:
            "5"
        case .`6`:
            "6"
        case .`7`:
            "7"
        case .`8`:
            "8"
        case .`9`:
            "9"
        case .`10`:
            "T"
        case .jack:
            "J"
        case .queen:
            "Q"
        case .king:
            "K"
        }
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        "\(suit)\(rank)"
    }
}

extension Card {
    static var allCards: [Card] {
        let cards: [Card] = [
            .init(suit: .spade, rank: .ace),
            .init(suit: .heart, rank: .ace),
            .init(suit: .club, rank: .ace),
            .init(suit: .diamond, rank: .ace),

            .init(suit: .spade, rank: .`2`),
            .init(suit: .heart, rank: .`2`),
            .init(suit: .club, rank: .`2`),
            .init(suit: .diamond, rank: .`2`),

            .init(suit: .spade, rank: .`3`),
            .init(suit: .heart, rank: .`3`),
            .init(suit: .club, rank: .`3`),
            .init(suit: .diamond, rank: .`3`),

            .init(suit: .spade, rank: .`4`),
            .init(suit: .heart, rank: .`4`),
            .init(suit: .club, rank: .`4`),
            .init(suit: .diamond, rank: .`4`),

            .init(suit: .spade, rank: .`5`),
            .init(suit: .heart, rank: .`5`),
            .init(suit: .club, rank: .`5`),
            .init(suit: .diamond, rank: .`5`),

            .init(suit: .spade, rank: .`6`),
            .init(suit: .heart, rank: .`6`),
            .init(suit: .club, rank: .`6`),
            .init(suit: .diamond, rank: .`6`),

            .init(suit: .spade, rank: .`7`),
            .init(suit: .heart, rank: .`7`),
            .init(suit: .club, rank: .`7`),
            .init(suit: .diamond, rank: .`7`),

            .init(suit: .spade, rank: .`8`),
            .init(suit: .heart, rank: .`8`),
            .init(suit: .club, rank: .`8`),
            .init(suit: .diamond, rank: .`8`),

            .init(suit: .spade, rank: .`9`),
            .init(suit: .heart, rank: .`9`),
            .init(suit: .club, rank: .`9`),
            .init(suit: .diamond, rank: .`9`),

            .init(suit: .spade, rank: .`10`),
            .init(suit: .heart, rank: .`10`),
            .init(suit: .club, rank: .`10`),
            .init(suit: .diamond, rank: .`10`),

            .init(suit: .spade, rank: .jack),
            .init(suit: .heart, rank: .jack),
            .init(suit: .club, rank: .jack),
            .init(suit: .diamond, rank: .jack),

            .init(suit: .spade, rank: .queen),
            .init(suit: .heart, rank: .queen),
            .init(suit: .club, rank: .queen),
            .init(suit: .diamond, rank: .queen),

            .init(suit: .spade, rank: .king),
            .init(suit: .heart, rank: .king),
            .init(suit: .club, rank: .king),
            .init(suit: .diamond, rank: .king),
        ]
        assert(cards.count == 52)
        assert(Set(cards).count == cards.count)
        return cards
    }
}
