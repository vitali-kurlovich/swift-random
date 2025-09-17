//
//  Shuffle.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

public enum ShuffleAlgorithm {
    /// Fisher Yates Shuffle
    /// - Complexity: O(*n*), where *n* is the length of the sequence
    case `default`

    case faro(FaroShuffleConfiguration)
}

public struct FaroShuffleConfiguration: Hashable, Sendable {
    public var count: Int
    public var middleShift: ClosedRange = 0 ... 0

    public init(count: Int = 1) {
        assert(count > 0)
        self.count = count
    }
}

public extension Sequence {
    /// Returns the elements of the sequence, shuffled using the shuffling algorithm and  the given generator
    /// as a source for randomness.
    ///
    /// - Parameter algorithm: The shuffle algorithm to use when shuffling
    ///
    /// - Parameter generator: The random number generator to use when shuffling
    ///   the sequence.
    /// - Returns: An array of this sequence's elements in a shuffled order.
    ///
    /// - Complexity: Depends on algorithm

    @inlinable func shuffled<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) -> [Element] where T: RandomNumberGenerator {
        switch algorithm {
        case .default:
            return fisherYatesShuffled(using: &generator)
        case let .faro(configuration):
            return faroShuffled(configuration: configuration, using: &generator)
        }
    }
}

public extension Array {
    /// Shuffle array using random generator and algorithm
    @inlinable mutating func shuffle<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) where T: RandomNumberGenerator {
        switch algorithm {
        case .default:
            fisherYatesShuffle(using: &generator)
        case let .faro(configuration):
            faroShuffle(configuration: configuration, using: &generator)
        }
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
public extension InlineArray {
    @inlinable mutating func shuffle<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) where T: RandomNumberGenerator {
        switch algorithm {
        case .default:
            fisherYatesShuffle(using: &generator)
        case .faro:
            faroShuffle(using: &generator)
        }
    }

    @inlinable func shuffled<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) -> Self where T: RandomNumberGenerator {
        var array = self
        array.shuffle(algorithm: algorithm, using: &generator)
        return array
    }
}
