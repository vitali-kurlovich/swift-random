//
//  SeedTests.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID
@testable import Random
import Testing

@Test("UInt32 Seed")
func UInt32_seed() {
    #expect(UInt32(seed: 0x0000_0000_FFFF_FFFF) == 0xFFFF_FFFF)
    #expect(UInt32(seed: 0xFFFF_FFFF_FFFF_FFFF) == 0xFFFF_FFFF ^ 0xFFFF_FFFF)
    #expect(UInt32(seed: 0xFFFF_FFFF_0000_0000) == 0x0000_0000 ^ 0xFFFF_FFFF)
    #expect(UInt32(seed: 0xFFFF_FFFF_7777_7777) == 0x7777_7777 ^ 0xFFFF_FFFF)

    #expect(UInt32(seed: 0xFAFA_1010_FFFF_FFFF) == 0xFFFF_FFFF ^ 0xFAFA_1010)
    #expect(UInt32(seed: 0xFAFA_1010_0000_0000) == 0x0000_0000 ^ 0xFAFA_1010)
    #expect(UInt32(seed: 0xFAFA_1010_7777_7777) == 0x7777_7777 ^ 0xFAFA_1010)
}

@Test("UUID Seed")
func UUID_seed() {
    let uuid = UUID(uuid: (0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, /* | */ 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00))

    let seed: UInt64 = 0x0000_0000_FFFF_FFFF ^ 0xFFFF_FFFF_0000_0000
    #expect(uuid.seed == seed)
}
