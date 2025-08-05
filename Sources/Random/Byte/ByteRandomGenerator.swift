//
//  ByteRandomGenerator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 5.08.25.
//

public struct ByteRandomGenerator<T> where T: RandomNumberGenerator {
    @usableFromInline var generator: T

    @usableFromInline var last: UInt64 = 0

    @inlinable
    public init(_ generator: T) {
        self.generator = generator
    }

    @inlinable
    public mutating func next() -> UInt8 {
        if last == 0 {
            last = generator.next()
        }

        defer {
            last = last >> 8
        }

        return UInt8(last & 0xFF)
    }
}
