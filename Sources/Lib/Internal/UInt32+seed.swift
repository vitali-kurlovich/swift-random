//
//  UInt32+seed.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

extension UInt32 {
    init(seed: UInt64) {
        self.init(truncatingIfNeeded: seed ^ (seed >> 32))
    }
}
