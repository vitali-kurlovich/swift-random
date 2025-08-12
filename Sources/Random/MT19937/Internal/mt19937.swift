//
//  mt19937.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 2.04.25.
//

@usableFromInline
struct mt_state_t: Equatable {
    private var mt = ContiguousArray(repeating: UInt32(0), count: 624)
    private var mti: Int = 0
}

extension mt_state_t {
    mutating func mt_set(s: UInt32) {
        let s = s == 0 ? 4357 : s

        mt[0] = s & 0xFFFF_FFFF

        for i in 1 ..< 624 {
            let mt = self.mt[i - 1]

            self.mt[i] = (mt ^ (mt >> 30))
                .multipliedReportingOverflow(by: 1_812_433_253)
                .partialValue
                .addingReportingOverflow(UInt32(i))
                .partialValue
        }
        mti = 624
    }

    @usableFromInline
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

    @usableFromInline
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
        if mti >= .N {
            var i = 0

            while i < .N - .M {
                let y = (mt[i] & .UPPER_MASK) | (mt[i + 1] & .LOWER_MASK)
                mt[i] = mt[i + .M] ^ (y >> 1) ^ magic(y)
                i += 1
            }

            while i < .N - 1 {
                let y = (mt[i] & .UPPER_MASK) | (mt[i + 1] & .LOWER_MASK)
                mt[i] = mt[i + (.M - .N)] ^ (y >> 1) ^ magic(y)
                i += 1
            }

            let y = (mt[.N - 1] & .UPPER_MASK) | (mt[0] & .LOWER_MASK)
            mt[.N - 1] = mt[.M - 1] ^ (y >> 1) ^ magic(y)

            mti = 0
        }
    }
}

extension mt_state_t {
    init<C: Collection>(mt: C, mti: Int) where C.Element == UInt32 {
        assert(mt.count == mt.count)
        self.mt = .init(mt)
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
    static var N: Int { 624 }
    @inline(__always)
    static var M: Int { 397 }
}
