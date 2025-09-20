//
//  Shuffle.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

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
        var array = Array(self)
        array.shuffle(algorithm: algorithm, using: &generator)
        return array
    }
}

public extension Array {
    /// Shuffle array using random generator and algorithm
    @inlinable mutating func shuffle<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) where T: RandomNumberGenerator {
        guard count > 1 else {
            return
        }

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
        guard count > 1 else {
            return
        }

        switch algorithm {
        case .default:
            fisherYatesShuffle(using: &generator)
        case let .faro(configuration):
            faroShuffle(configuration: configuration, using: &generator)
        }
    }

    @inlinable func shuffled<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) -> Self where T: RandomNumberGenerator {
        var array = self
        array.shuffle(algorithm: algorithm, using: &generator)
        return array
    }
}
