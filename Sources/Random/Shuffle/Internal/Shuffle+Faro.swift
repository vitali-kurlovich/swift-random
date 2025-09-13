//
//  Shuffle+Faro.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 13.09.25.
//

extension Array {
    @inlinable
    mutating func faroShuffle<T>(configuration: FaroShuffleConfiguration, using _: inout T) where T: RandomNumberGenerator {
        let count = self.count

        guard count > 1 else {
            return
        }

        for _ in 0 ..< configuration.count {
            let copy = self

            let midIndex = (startIndex + endIndex) / 2

            var leftRange = startIndex ..< midIndex
            var rightRange = midIndex ..< endIndex

            var finish = false

            var indexIterator = indices.makeIterator()

            func applyLeft() {
                if !leftRange.isEmpty {
                    let range = leftRange.lowerBound ..< Swift.min(leftRange.lowerBound + 1, leftRange.upperBound)
                    leftRange = range.upperBound ..< leftRange.upperBound

                    for index in range {
                        let dstIndex = indexIterator.next()!
                        self[dstIndex] = copy[index]
                    }
                }
            }

            func applyRight() {
                if !rightRange.isEmpty {
                    let range = rightRange.lowerBound ..< Swift.min(rightRange.lowerBound + 1, rightRange.upperBound)
                    rightRange = range.upperBound ..< rightRange.upperBound

                    for index in range {
                        let dstIndex = indexIterator.next()!
                        self[dstIndex] = copy[index]
                    }
                }
            }

            switch configuration.type {
            case .in:
                while !finish {
                    applyLeft()
                    applyRight()
                    finish = leftRange.isEmpty && rightRange.isEmpty
                }
            case .out:
                while !finish {
                    applyRight()
                    applyLeft()
                    finish = leftRange.isEmpty && rightRange.isEmpty
                }
            }
        }
    }
}

extension Sequence {
    @inlinable
    func faroShuffled<T>(configuration: FaroShuffleConfiguration, using generator: inout T) -> [Element] where T: RandomNumberGenerator {
        var array = Array(self)
        array.faroShuffle(configuration: configuration, using: &generator)
        return array
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
extension InlineArray {
    @inlinable
    mutating func faroShuffle<T>(using _: inout T) where T: RandomNumberGenerator {
        fatalError("Do not mplemented")
    }
}
