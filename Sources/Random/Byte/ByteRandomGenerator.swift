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

        let result = UInt8(last & 0xFF)
        last = last >> 8
        return result
    }
}
