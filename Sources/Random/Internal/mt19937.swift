//
//  mt19937.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 2.04.25.
//

@usableFromInline
struct mt_state_t: Equatable {
    @usableFromInline
    let mt = FixedSizeBuffer<UInt32>(count: 624)

    @usableFromInline
    var mti: Int = 0
}

extension mt_state_t {
    @inlinable
    @inline(__always)
    mutating func mt_set(s: UInt32) {
        let s = s == 0 ? 4357 : s

        mt[0] = s & 0xFFFF_FFFF

        for i in 1 ..< 624 {
            let mt = UInt64(self.mt[i - 1])
            let hash = (1_812_433_253 * (mt ^ (mt >> 30)) + UInt64(i)) & 0xFFFF_FFFF
            self.mt[i] = UInt32(truncatingIfNeeded: hash)
        }
        mti = 624
    }

    @inlinable
    @inline(__always)
    mutating func mt_get() -> UInt32 {
        @inline(__always)
        func magic<B: BinaryInteger>(_ y: B) -> B {
            (y & 0x1) != 0 ? 0x9908_B0DF : 0
        }

        if mti >= 624 {
            var kk = 0
            while kk < 624 - 397 {
                let y = (mt[kk] & 0x8000_0000) | (mt[kk + 1] & 0x7FFF_FFFF)
                mt[kk] = mt[kk + 397] ^ (y >> 1) ^ magic(y)
                kk += 1
            }

            while kk < 624 - 1 {
                let y = (mt[kk] & 0x8000_0000) | (mt[kk + 1] & 0x7FFF_FFFF)
                mt[kk] = mt[kk + (397 - 624)] ^ (y >> 1) ^ magic(y)
                kk += 1
            }

            let y = (mt[624 - 1] & 0x8000_0000) | (mt[0] & 0x7FFF_FFFF)
            mt[624 - 1] = mt[397 - 1] ^ (y >> 1) ^ magic(y)

            mti = 0
        }

        var k = mt[mti]
        k ^= (k >> 11)
        k ^= (k << 7) & 0x9D2C_5680
        k ^= (k << 15) & 0xEFC6_0000
        k ^= (k >> 18)

        mti += 1

        return k
    }
}

extension mt_state_t {
    init(mt: [UInt32], mti: Int) {
        assert(mt.count == mt.count)

        for index in 0 ..< mt.count {
            self.mt[index] = mt[index]
        }

        self.mti = mti
    }
}
