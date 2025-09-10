//
//  MT19937x32.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 2.04.25.
//

@usableFromInline
struct MT19937x32: Equatable {
    private var mt = ContiguousArray(repeating: UInt32(0), count: 624)
    private var mti: Int = 0
}

extension MT19937x32 {
    @usableFromInline
    @inline(__always)
    init(seed: UInt32 = 4357) {
        let seed = seed == 0 ? 4357 : seed

        var mt = ContiguousArray(repeating: UInt32(0), count: 624)
        var i = 1

        mt[0] = seed & 0xFFFF_FFFF

        while i < .N {
            let x = mt[i - 1]

            mt[i] = (x ^ (x >> 30))
                .multipliedReportingOverflow(by: 1_812_433_253)
                .partialValue
                .addingReportingOverflow(UInt32(i))
                .partialValue

            i += 1
        }

        self.init(mt: mt, mti: .N)
    }
}

extension MT19937x32 {
    @usableFromInline
    @inline(__always)
    mutating func random() -> UInt32 {
        if mti >= .N {
            var i = 0

            while i < .N - .M {
                let y = (mt[i] & .UPPER_MASK) | (mt[i + 1] & .LOWER_MASK)
                mt[i] = mt[i + .M] ^ (y >> 1) ^ ((y & 0x1) * 0x9908_B0DF)
                i += 1
            }

            while i < .N - 1 {
                let y = (mt[i] & .UPPER_MASK) | (mt[i + 1] & .LOWER_MASK)
                mt[i] = mt[i + (.M - .N)] ^ (y >> 1) ^ ((y & 0x1) * 0x9908_B0DF)
                i += 1
            }

            let y = (mt[.N - 1] & .UPPER_MASK) | (mt[0] & .LOWER_MASK)
            mt[.N - 1] = mt[.M - 1] ^ (y >> 1) ^ ((y & 0x1) * 0x9908_B0DF)

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

extension MT19937x32 {
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
