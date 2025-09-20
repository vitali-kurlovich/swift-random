//
//  Shuffle+Faro.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 13.09.25.
//

extension Array {
    @inlinable
    mutating func faroShuffle<T>(configuration: FaroShuffleConfiguration, using generator: inout T) where T: RandomNumberGenerator {
        assert(count > 1)

        var boolGenerator = BitRandomGenerator(generator)

        for _ in 0 ..< configuration.count {
            let copy = self

            var isInShuffle = boolGenerator.next()

            var midIndex = (startIndex + endIndex) / 2

            if isInShuffle && 2 * midIndex - startIndex != endIndex {
                midIndex += 1
            }

            let offset = configuration.middleShiftRange.randomElement(using: &generator)!
            midIndex += offset

            midIndex = Swift.max(midIndex, startIndex)
            midIndex = Swift.min(midIndex, endIndex)

            if midIndex - startIndex < endIndex - midIndex {
                isInShuffle = false
            } else if midIndex - startIndex > endIndex - midIndex {
                isInShuffle = true
            }

            var leftIndex = startIndex
            var rightIndex = midIndex

            var finish = false

            var indexIterator = indices.makeIterator()

            func applyLeft() {
                if leftIndex < midIndex {
                    let offset = configuration.stuckCardsRange.randomElement(using: &generator)!

                    let range = leftIndex ..< Swift.min(leftIndex + offset, midIndex)
                    leftIndex = range.upperBound

                    for index in range {
                        let dstIndex = indexIterator.next()!
                        self[dstIndex] = copy[index]
                    }
                }
            }

            func applyRight() {
                if rightIndex < endIndex {
                    let offset = configuration.stuckCardsRange.randomElement(using: &generator)!

                    let range = rightIndex ..< Swift.min(rightIndex + offset, endIndex)
                    rightIndex = range.upperBound

                    for index in range {
                        let dstIndex = indexIterator.next()!
                        self[dstIndex] = copy[index]
                    }
                }
            }

            if isInShuffle {
                // In-Shuffle
                while !finish {
                    applyLeft()
                    applyRight()
                    finish = leftIndex == midIndex && rightIndex == endIndex
                }
            } else {
                // Out-Shuffle
                while !finish {
                    applyRight()
                    applyLeft()
                    finish = leftIndex == midIndex && rightIndex == endIndex
                }
            }
        }
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
extension InlineArray {
    @inlinable
    mutating func faroShuffle<T>(configuration: FaroShuffleConfiguration, using generator: inout T) where T: RandomNumberGenerator {
        assert(count > 1)

        var boolGenerator = BitRandomGenerator(generator)

        for _ in 0 ..< configuration.count {
            let copy = self

            var isInShuffle = boolGenerator.next()

            var midIndex = (startIndex + endIndex) / 2

            if isInShuffle && 2 * midIndex - startIndex != endIndex {
                midIndex += 1
            }

            let offset = configuration.middleShiftRange.randomElement(using: &generator)!
            midIndex += offset

            midIndex = Swift.max(midIndex, startIndex)
            midIndex = Swift.min(midIndex, endIndex)

            if midIndex - startIndex < endIndex - midIndex {
                isInShuffle = false
            } else if midIndex - startIndex > endIndex - midIndex {
                isInShuffle = true
            }

            var leftIndex = startIndex
            var rightIndex = midIndex

            var finish = false

            var indexIterator = indices.makeIterator()

            func applyLeft() {
                if leftIndex < midIndex {
                    let offset = configuration.stuckCardsRange.randomElement(using: &generator)!

                    let range = leftIndex ..< Swift.min(leftIndex + offset, midIndex)
                    leftIndex = range.upperBound

                    for index in range {
                        let dstIndex = indexIterator.next()!
                        self[dstIndex] = copy[index]
                    }
                }
            }

            func applyRight() {
                if rightIndex < endIndex {
                    let offset = configuration.stuckCardsRange.randomElement(using: &generator)!

                    let range = rightIndex ..< Swift.min(rightIndex + offset, endIndex)
                    rightIndex = range.upperBound

                    for index in range {
                        let dstIndex = indexIterator.next()!
                        self[dstIndex] = copy[index]
                    }
                }
            }

            if isInShuffle {
                // In-Shuffle
                while !finish {
                    applyLeft()
                    applyRight()
                    finish = leftIndex == midIndex && rightIndex == endIndex
                }
            } else {
                // Out-Shuffle
                while !finish {
                    applyRight()
                    applyLeft()
                    finish = leftIndex == midIndex && rightIndex == endIndex
                }
            }
        }
    }
}
