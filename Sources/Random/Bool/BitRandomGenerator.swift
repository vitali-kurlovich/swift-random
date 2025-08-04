//
//  BitRandomGenerator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 5.08.25.
//

public struct BitRandomGenerator<T> where T: RandomNumberGenerator {
    @usableFromInline var generator: T

    @usableFromInline var last: UInt64 = 0
    @usableFromInline var mask: UInt64 = 0

    public init(_ generator: T) {
        self.generator = generator
    }

    @inlinable
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
