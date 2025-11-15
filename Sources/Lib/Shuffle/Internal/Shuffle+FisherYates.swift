//
//  Shuffle+FisherYates.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 8.09.25.
//

extension Array {
    @inlinable
    mutating func fisherYatesShuffle(using generator: inout some RandomNumberGenerator) {
        assert(count > 1)

        let indexes = startIndex ... index(before: index(before: endIndex))

        for i in indexes {
            let rndIndexes = i ... index(before: endIndex)
            let j = rndIndexes.randomElement(using: &generator)!
            swapAt(i, j)
        }
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
extension InlineArray {
    @inlinable
    mutating func fisherYatesShuffle(using generator: inout some RandomNumberGenerator) {
        assert(count > 1)

        let indexes = startIndex ... index(before: index(before: endIndex))

        for i in indexes {
            let rndIndexes = i ... index(before: endIndex)
            let j = rndIndexes.randomElement(using: &generator)!
            swapAt(i, j)
        }
    }
}
