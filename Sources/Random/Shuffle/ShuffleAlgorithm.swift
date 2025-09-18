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
    public var count: Int

    public var middleShiftRange: ClosedRange<Int>
    public var stuckCardsRange: ClosedRange<Int>

    public init(count: Int = 1, middleShiftRange: ClosedRange<Int> = 0 ... 0, stuckCardsRange: ClosedRange<Int> = 1 ... 1) {
        assert(count > 0)
        assert(stuckCardsRange.lowerBound > 0)

        self.count = count
        self.middleShiftRange = middleShiftRange
        self.stuckCardsRange = stuckCardsRange
    }
}
