//
//  MT19937RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

import struct Foundation.UUID

public struct MT19937RandomGenegator: RandomNumberGenerator {
    private var state: mt_state_t

    private init(state: mt_state_t) {
        self.state = state
    }

    public init(seed: UInt64) {
        var state: mt_state_t = .init()
        mt_set(state: &state, s: .init(truncatingIfNeeded: seed))
        self.init(state: state)
    }

    public
    mutating func next() -> UInt64 {
        var state = self.state

        let prev = UInt64(mt_get(state: &state))
        let next = UInt64(mt_get(state: &state))

        self.state = state

        return prev ^ (next << 32)
    }
}

public
extension MT19937RandomGenegator {
    init(uuid: UUID = UUID()) {
        self.init(seed: uuid.seed)
    }
}
