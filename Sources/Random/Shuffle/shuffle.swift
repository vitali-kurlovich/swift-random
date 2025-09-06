//
//  shuffle.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

public extension Sequence {
    func shuffled<T>(algorithm: ShuffleAlgorithm = .default, using generator: inout T) -> [Element] where T: RandomNumberGenerator {
        switch algorithm {
        case .default:
            return defaultShuffled(using: &generator)
        }
    }
}

public enum ShuffleAlgorithm {
    case `default`
}

extension Sequence {
    @inlinable
    func defaultShuffled<T>(using generator: inout T) -> [Element] where T: RandomNumberGenerator {
        var array = Array(self)

        guard array.count > 1 else {
            return array
        }

        var result: [Element] = []
        result.reserveCapacity(array.count)

        while array.count > 1, let index = array.indices.randomElement(using: &generator) {
            let element = array.remove(at: index)
            result.append(element)
        }

        result.append(contentsOf: array)

        return result
    }
}

// @inlinable public func shuffled() -> [Element]
