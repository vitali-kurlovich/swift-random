//
//  BitRandomGeneratorTests.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 5.08.25.
//

import Random
import Testing

@Test
func bitRandomGenerator() {
    let fixedGenerator = FixedRandomNumberGenerator(value: 0b1010_0011_1010_0001_1111_0000_1010_0101_1010_0011_1010_0001_1111_0000_1010_0101)

    var generator = BitRandomGenerator(fixedGenerator)
    for _ in 0 ..< 10 {
        #expect(generator.next() == true)
        #expect(generator.next() == false)
        #expect(generator.next() == true)
        #expect(generator.next() == false)

        #expect(generator.next() == false)
        #expect(generator.next() == true)
        #expect(generator.next() == false)
        #expect(generator.next() == true)

        #expect(generator.next() == false)
        #expect(generator.next() == false)
        #expect(generator.next() == false)
        #expect(generator.next() == false)

        #expect(generator.next() == true)
        #expect(generator.next() == true)
        #expect(generator.next() == true)
        #expect(generator.next() == true)

        #expect(generator.next() == true)
        #expect(generator.next() == false)
        #expect(generator.next() == false)
        #expect(generator.next() == false)

        #expect(generator.next() == false)
        #expect(generator.next() == true)
        #expect(generator.next() == false)
        #expect(generator.next() == true)

        #expect(generator.next() == true)
        #expect(generator.next() == true)
        #expect(generator.next() == false)
        #expect(generator.next() == false)

        #expect(generator.next() == false)
        #expect(generator.next() == true)
        #expect(generator.next() == false)
        #expect(generator.next() == true)
    }
}
