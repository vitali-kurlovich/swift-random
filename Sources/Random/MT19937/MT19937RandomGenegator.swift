//
//  MT19937RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

public struct MT19937RandomGenegator: RandomNumberGenerator {
    @usableFromInline var state: mt19937_64

    public init(seed: UInt64) {
        state = .init(seed: seed)
    }

    @inlinable
    public mutating func next() -> UInt64 {
        return state.random()
    }
}

public extension MT19937RandomGenegator {
    init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}

#if swift(>=6.2)

    @available(iOS 26.0, *)
    @available(macOS 26.0, *)
    public struct FastMT19937RandomGenegator: RandomNumberGenerator {
        @usableFromInline var state: fast_mt19937_64

        public init(seed: UInt64) {
            state = .init(seed: seed)
        }

        @inlinable
        public mutating func next() -> UInt64 {
            return state.random()
        }
    }

    @available(iOS 26.0, *)
    @available(macOS 26.0, *)
    public extension FastMT19937RandomGenegator {
        init(uuid: UUID = UUID()) {
            self.init(seed: uuid.seed)
        }
    }

#endif // swift(>=6.2)
