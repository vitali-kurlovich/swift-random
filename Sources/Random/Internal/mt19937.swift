//
//  mt19937.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 2.04.25.
//

@usableFromInline
struct mt_state_t: Equatable {
    @usableFromInline
    var mt: [UInt32] = Array(repeating: 0, count: 624)
    @usableFromInline
    var mti: Int = 0
}

@inlinable
@inline(__always)
func mt_set(state: inout mt_state_t, s: UInt32) {
    let s = s == 0 ? 4357 : s

    state.mt[0] = s & 0xFFFF_FFFF

    for i in 1 ..< 624 {
        let mt = UInt64(state.mt[i - 1])
        let hash = (1_812_433_253 * (mt ^ (mt >> 30)) + UInt64(i)) & 0xFFFF_FFFF
        state.mt[i] = UInt32(truncatingIfNeeded: hash)
    }
    state.mti = 624
}

@inlinable
@inline(__always)
func mt_get(state: inout mt_state_t) -> UInt32 {
    @inline(__always)
    func magic<B: BinaryInteger>(_ y: B) -> B {
        (y & 0x1) != 0 ? 0x9908_B0DF : 0
    }

    if state.mti >= 624 {
        var kk = 0
        while kk < 624 - 397 {
            let y = (state.mt[kk] & 0x8000_0000) | (state.mt[kk + 1] & 0x7FFF_FFFF)
            state.mt[kk] = state.mt[kk + 397] ^ (y >> 1) ^ magic(y)
            kk += 1
        }

        while kk < 624 - 1 {
            let y = (state.mt[kk] & 0x8000_0000) | (state.mt[kk + 1] & 0x7FFF_FFFF)
            state.mt[kk] = state.mt[kk + (397 - 624)] ^ (y >> 1) ^ magic(y)
            kk += 1
        }

        let y = (state.mt[624 - 1] & 0x8000_0000) | (state.mt[0] & 0x7FFF_FFFF)
        state.mt[624 - 1] = state.mt[397 - 1] ^ (y >> 1) ^ magic(y)

        state.mti = 0
    }

    var k = state.mt[state.mti]
    k ^= (k >> 11)
    k ^= (k << 7) & 0x9D2C_5680
    k ^= (k << 15) & 0xEFC6_0000
    k ^= (k >> 18)

    state.mti += 1

    return k
}
