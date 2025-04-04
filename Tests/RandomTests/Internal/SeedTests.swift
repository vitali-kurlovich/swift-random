//
//  SeedTests.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

@testable import Random
import XCTest

final class SeedTests: XCTestCase {
    func testUInt32() {
        XCTAssertEqual(UInt32(seed: 0x0000_0000_FFFF_FFFF), 0xFFFF_FFFF)
        XCTAssertEqual(UInt32(seed: 0xFFFF_FFFF_FFFF_FFFF), 0xFFFF_FFFF ^ 0xFFFF_FFFF)
        XCTAssertEqual(UInt32(seed: 0xFFFF_FFFF_0000_0000), 0x0000_0000 ^ 0xFFFF_FFFF)
        XCTAssertEqual(UInt32(seed: 0xFFFF_FFFF_7777_7777), 0x7777_7777 ^ 0xFFFF_FFFF)

        XCTAssertEqual(UInt32(seed: 0xFAFA_1010_FFFF_FFFF), 0xFFFF_FFFF ^ 0xFAFA_1010)
        XCTAssertEqual(UInt32(seed: 0xFAFA_1010_0000_0000), 0x0000_0000 ^ 0xFAFA_1010)
        XCTAssertEqual(UInt32(seed: 0xFAFA_1010_7777_7777), 0x7777_7777 ^ 0xFAFA_1010)
    }

    func testUUID() {
        let uuid = UUID(uuid: (0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, /* | */ 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00))

        XCTAssertEqual(uuid.seed, 0x0000_0000_FFFF_FFFF ^ 0xFFFF_FFFF_0000_0000)
    }
}
