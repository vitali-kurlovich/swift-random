//
//  ShuffleAlgorithm.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 18.09.25.
//

public enum ShuffleAlgorithm {
    /// Fisher Yates Shuffle
    /// - Complexity: O(*n*), where *n* is the length of the sequence
    case `default`

    case faro(FaroShuffleConfiguration)
}

public struct FaroShuffleConfiguration: Hashable, Sendable {
    public var rounds: Int

    public var middleShiftRange: ClosedRange<Int>
    public var stuckCardsRange: ClosedRange<Int>

    public init(count: Int = 8, middleShiftRange: ClosedRange<Int> = 0 ... 0, stuckCardsRange: ClosedRange<Int> = 1 ... 1) {
        assert(count > 0)
        assert(stuckCardsRange.lowerBound > 0)

        rounds = count
        self.middleShiftRange = middleShiftRange
        self.stuckCardsRange = stuckCardsRange
    }
}

extension ShuffleAlgorithm: CustomStringConvertible {
    public var description: String {
        switch self {
        case .default:
            return "default"
        case let .faro(configuration):
            return "faro(\(configuration.rounds))"
        }
    }
}
