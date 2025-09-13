//
//  Shuffle+FisherYates.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 8.09.25.
//

extension Array {
    @inlinable
    mutating func fisherYatesShuffle<T>(using generator: inout T) where T: RandomNumberGenerator {
        let count = self.count

        guard count > 1 else {
            return
        }

        let indexes = startIndex ... index(before: index(before: endIndex))

        for i in indexes {
            let rndIndexes = i ... index(before: endIndex)
            let j = rndIndexes.randomElement(using: &generator)!
            swapAt(i, j)
        }
    }
}

extension Sequence {
    @inlinable
    func fisherYatesShuffled<T>(using generator: inout T) -> [Element] where T: RandomNumberGenerator {
        var array = Array(self)
        array.fisherYatesShuffle(using: &generator)
        return array
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
extension InlineArray {
    @inlinable
    mutating func fisherYatesShuffle<T>(using generator: inout T) where T: RandomNumberGenerator {
        let count = self.count

        guard count > 1 else {
            return
        }

        let indexes = startIndex ... index(before: index(before: endIndex))

        for i in indexes {
            let rndIndexes = i ... index(before: endIndex)
            let j = rndIndexes.randomElement(using: &generator)!
            swapAt(i, j)
        }
    }
}
