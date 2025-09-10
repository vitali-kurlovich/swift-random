//
//  mt19937_64.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 11.08.25.
//

@usableFromInline
struct mt19937_64: Equatable {
    private var mt: ContiguousArray<UInt64>
    private var mti: Int
}

extension mt19937_64 {
    @inline(__always)
    init(seed: UInt64 = 5489) {
        var mt = ContiguousArray(repeating: UInt64(0), count: .NN)
        mt[0] = seed

        for mti in 1 ..< .NN {
            mt[mti] = (mt[mti - 1] ^ (mt[mti - 1] >> 62))
                .multipliedReportingOverflow(by: 6_364_136_223_846_793_005)
                .partialValue
                .addingReportingOverflow(UInt64(mti))
                .partialValue
        }

        self.init(mt: mt, mti: .NN)
    }

    @usableFromInline
    @inline(__always)
    mutating func random() -> UInt64 {
        if mti >= .NN {
            var x: UInt64

            for i in 0 ..< (.NN - .MM) {
                x = (mt[i] & .UM) | (mt[i + 1] & .LM)
                mt[i] = mt[i + .MM] ^ (x >> 1) ^ ((x & 0x1) * .MATRIX_A)
            }

            for i in (.NN - .MM) ..< (.NN - 1) {
                x = (mt[i] & .UM) | (mt[i + 1] & .LM)
                mt[i] = mt[i + (.MM - .NN)] ^ (x >> 1) ^ ((x & 0x1) * .MATRIX_A)
            }

            x = (mt[.NN - 1] & .UM) | (mt[0] & .LM)
            mt[.NN - 1] = mt[.MM - 1] ^ (x >> 1) ^ ((x & 0x1) * .MATRIX_A)

            mti = 0
        }

        var x = mt[mti]
        mti += 1

        x ^= (x >> 29) & 0x5555_5555_5555_5555
        x ^= (x << 17) & 0x71D6_7FFF_EDA6_0000
        x ^= (x << 37) & 0xFFF7_EEE0_0000_0000
        x ^= (x >> 43)

        return x
    }
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
@usableFromInline
struct fast_mt19937_64 {
    private var mt: InlineArray<312, UInt64>
    private var mti: Int
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
extension fast_mt19937_64 {
    @inline(__always)
    init(seed: UInt64 = 5489) {
        var mt: InlineArray<312, UInt64> = .init(repeating: 0)
        mt[0] = seed

        for mti in 1 ..< .NN {
            mt[mti] = (mt[mti - 1] ^ (mt[mti - 1] >> 62))
                .multipliedReportingOverflow(by: 6_364_136_223_846_793_005)
                .partialValue
                .addingReportingOverflow(UInt64(mti))
                .partialValue
        }

        self.init(mt: mt, mti: .NN)
    }

    @usableFromInline
    @inline(__always)
    mutating func random() -> UInt64 {
        if mti >= .NN {
            var x: UInt64

            for i in 0 ..< (.NN - .MM) {
                x = (mt[i] & .UM) | (mt[i + 1] & .LM)
                mt[i] = mt[i + .MM] ^ (x >> 1) ^ ((x & 0x1) * .MATRIX_A)
            }

            for i in (.NN - .MM) ..< (.NN - 1) {
                x = (mt[i] & .UM) | (mt[i + 1] & .LM)
                mt[i] = mt[i + (.MM - .NN)] ^ (x >> 1) ^ ((x & 0x1) * .MATRIX_A)
            }

            x = (mt[.NN - 1] & .UM) | (mt[0] & .LM)
            mt[.NN - 1] = mt[.MM - 1] ^ (x >> 1) ^ ((x & 0x1) * .MATRIX_A)

            mti = 0
        }

        var x = mt[mti]
        mti += 1

        x ^= (x >> 29) & 0x5555_5555_5555_5555
        x ^= (x << 17) & 0x71D6_7FFF_EDA6_0000
        x ^= (x << 37) & 0xFFF7_EEE0_0000_0000
        x ^= (x >> 43)

        return x
    }
}

private extension UInt64 {
    @inline(__always)
    static var MATRIX_A: UInt64 { 0xB502_6F5A_A966_19E9 }
    @inline(__always)
    static var UM: UInt64 { 0xFFFF_FFFF_8000_0000 } /* Most significant 33 bits */
    @inline(__always)
    static var LM: UInt64 { 0x7FFF_FFFF } /* Least significant 31 bits */
}

private extension Int {
    @inline(__always)
    static var NN: Int { 312 }
    @inline(__always)
    static var MM: Int { 156 }
}
