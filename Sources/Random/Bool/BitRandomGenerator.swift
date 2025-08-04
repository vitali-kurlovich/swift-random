//
//  BitRandomGenerator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 5.08.25.
//

public struct BitRandomGenerator<T> where T: RandomNumberGenerator {
    var generator: T

    var last: UInt64 = 0
    var mask: UInt64 = 0

    public init(_ generator: T) {
        self.generator = generator
    }

    public mutating func next() -> Bool {
        if mask == 0 {
            last = generator.next()
            mask = 1
        }

        defer {
            mask = mask << 1
        }

        return (last & mask) != 0
    }
}
