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

#if swift(>=6.2)

    @available(iOS 26.0, *)
    @available(macOS 26.0, *)
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

#endif // swift(>=6.2)
