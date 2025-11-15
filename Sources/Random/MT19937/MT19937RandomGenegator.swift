//
//  MT19937RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

public struct MT19937RandomGenegator: RandomNumberGenerator {
    @usableFromInline var state: MT19937x64

    @inlinable
    public mutating func next() -> UInt64 {
        state.random()
    }
}

public extension MT19937RandomGenegator {
    init(seed: UInt64) {
        self.init(state: .init(seed: seed))
    }

    @inlinable init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
public struct InlineMT19937RandomGenegator: RandomNumberGenerator {
    @usableFromInline var state: InlineMT19937x64

    @inlinable
    public mutating func next() -> UInt64 {
        state.random()
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
public extension InlineMT19937RandomGenegator {
    init(seed: UInt64) {
        self.init(state: .init(seed: seed))
    }

    @inlinable init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}
