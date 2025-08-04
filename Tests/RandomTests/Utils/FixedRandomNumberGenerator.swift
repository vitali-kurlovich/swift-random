//
//  FixedRandomNumberGenerator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 5.08.25.
//

struct FixedRandomNumberGenerator: RandomNumberGenerator {
    let value: UInt64

    mutating func next() -> UInt64 {
        value
    }
}
