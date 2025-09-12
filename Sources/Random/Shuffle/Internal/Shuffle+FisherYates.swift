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

extension Array {
    @inlinable
    mutating func faroShuffle<T>(using _: inout T) where T: RandomNumberGenerator {
        let count = self.count

        guard count > 1 else {
            return
        }

        let copy = self

        let midIndex = (startIndex + endIndex) / 2

        var leftRange = startIndex ..< midIndex
        var rightRange = midIndex ..< endIndex

        var finish = false

        var indexIterator = indices.makeIterator()

        while !finish {
            if !leftRange.isEmpty {
                let range = leftRange.lowerBound ..< Swift.min(leftRange.lowerBound + 1, leftRange.upperBound)
                leftRange = range.upperBound ..< leftRange.upperBound

                for index in range {
                    let dstIndex = indexIterator.next()!
                    self[dstIndex] = copy[index]
                }
            }

            if !rightRange.isEmpty {
                let range = rightRange.lowerBound ..< Swift.min(rightRange.lowerBound + 1, rightRange.upperBound)
                rightRange = range.upperBound ..< rightRange.upperBound

                for index in range {
                    let dstIndex = indexIterator.next()!
                    self[dstIndex] = copy[index]
                }
            }

            finish = leftRange.isEmpty && rightRange.isEmpty
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

    @inlinable
    func faroShuffled<T>(using generator: inout T) -> [Element] where T: RandomNumberGenerator {
        var array = Array(self)
        array.faroShuffle(using: &generator)
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
