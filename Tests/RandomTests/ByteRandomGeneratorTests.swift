//
//  ByteRandomGeneratorTests.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 5.08.25.
//

import Random
import Testing

@Test
func byteRandomGenerator() {
    let fixedGenerator = FixedRandomNumberGenerator(value: 0xF9F8_E7E6_D5D4_C3C2)

    var generator = ByteRandomGenerator(fixedGenerator)

    for _ in 0 ..< 10 {
        #expect(generator.next() == 0xC2)
        #expect(generator.next() == 0xC3)

        #expect(generator.next() == 0xD4)
        #expect(generator.next() == 0xD5)

        #expect(generator.next() == 0xE6)
        #expect(generator.next() == 0xE7)

        #expect(generator.next() == 0xF8)
        #expect(generator.next() == 0xF9)
    }
}
