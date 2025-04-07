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
            let mt = self.mt[i - 1]
            let hash = (1_812_433_253 * UInt64(mt ^ (mt >> 30)) + UInt64(i)) & 0xFFFF_FFFF
            self.mt[i] = UInt32(truncatingIfNeeded: hash)
        }
        mti = 624
    }

    @inline(__always)
    mutating func mt_get() -> UInt32 {
        mt_advance()

        var k = mt[mti]
        k ^= (k >> 11)
        k ^= (k << 7) & 0x9D2C_5680
        k ^= (k << 15) & 0xEFC6_0000
        k ^= (k >> 18)

        mti += 1

        return k
    }

    @inline(__always)
    mutating func mt_get64() -> UInt64 {
        mt_advance()

        var prev = mt[mti]
        var next = mt[mti + 1]

        prev ^= (prev >> 11)
        prev ^= (prev << 7) & 0x9D2C_5680
        prev ^= (prev << 15) & 0xEFC6_0000
        prev ^= (prev >> 18)

        next ^= (next >> 11)
        next ^= (next << 7) & 0x9D2C_5680
        next ^= (next << 15) & 0xEFC6_0000
        next ^= (next >> 18)

        mti += 2

        return (UInt64(prev) << 32) ^ UInt64(next)
    }

    @inline(__always)
    private func magic<B: BinaryInteger>(_ y: B) -> B {
        (y & 0x1) * 0x9908_B0DF
    }

    @inline(__always)
    private mutating func mt_advance() {
        if mti >= .M {
            for kk in 0 ..< .M - .N {
                let y = (mt[kk] & .UPPER_MASK) | (mt[kk + 1] & .LOWER_MASK)
                mt[kk] = mt[kk + .N] ^ (y >> 1) ^ magic(y)
            }

            for kk in .M - .N ..< .M - 1 {
                let y = (mt[kk] & .UPPER_MASK) | (mt[kk + 1] & .LOWER_MASK)
                mt[kk] = mt[kk + (.N - .M)] ^ (y >> 1) ^ magic(y)
            }

            let y = (mt[.M - 1] & .UPPER_MASK) | (mt[0] & .LOWER_MASK)
            mt[.M - 1] = mt[.N - 1] ^ (y >> 1) ^ magic(y)

            mti = 0
        }
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

private extension UInt32 {
    @inline(__always)
    static var UPPER_MASK: UInt32 { 0x8000_0000 }
    @inline(__always)
    static var LOWER_MASK: UInt32 { 0x7FFF_FFFF }
}

private extension Int {
    @inline(__always)
    static var M: Int { 624 }
    @inline(__always)
    static var N: Int { 397 }
}
