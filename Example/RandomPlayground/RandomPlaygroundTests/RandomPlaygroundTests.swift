//
//  RandomPlaygroundTests.swift
//  RandomPlaygroundTests
//
//  Created by Vitali Kurlovich on 10.10.25.
//

import Foundation
@testable import RandomPlayground
import Testing

struct RandomPlaygroundTests {
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
}

struct UUIDTests {
    @Test
    func uUIDData() throws {
        let uuid = UUID()

        let data = uuid.data

        let uuidFromData = try #require(UUID(data: data))

        #expect(uuid == uuidFromData)
    }
}
