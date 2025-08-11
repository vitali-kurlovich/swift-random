//
//  mt19937_64.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 11.08.25.
//

/*

 #define NN 312
 #define MM 156
 #define MATRIX_A 0xB5026F5AA96619E9ULL
 #define UM 0xFFFFFFFF80000000ULL /* Most significant 33 bits */
 #define LM 0x7FFFFFFFULL /* Least significant 31 bits */

 struct mt19937_64 {
     unsigned long long mt[NN];
     size_t mti;
 };

 */

@usableFromInline
struct mt19937_64: Equatable {
    private var mt = ContiguousArray(repeating: UInt64(0), count: .NN)
    private var mti: Int = 0
}

extension mt19937_64 {
    @inline(__always)
    init(seed: UInt64 = 5489) {
        var mt = ContiguousArray(repeating: UInt64(0), count: .NN)
        var mti = 1

        mt[0] = seed

        while mti < .MM {
            mt[mti] = (6_364_136_223_846_793_005 * (mt[mti - 1] ^ (mt[mti - 1] >> 62)) + UInt64(mti))
            mti += 1
        }

        self.init(mt: mt, mti: mti)
    }

    @inline(__always)
    private func magic(_ x: UInt64) -> UInt64 {
        (x & 0x1) != 0 ? .MATRIX_A : 0
    }

    @usableFromInline
    @inline(__always)
    mutating func rand() -> UInt64 {
        if mti >= .NN {
            var i = 0
            var x: UInt64

            while i < .NN - .MM {
                x = (mt[i] & .UM) | (mt[i + 1] & .LM)
                mt[i] = mt[i + .MM] ^ (x >> 1) ^ magic(x)
                i += 1
            }

            while i < .NN - 1 {
                x = (mt[i] & .UM) | (mt[i + 1] & .LM)
                mt[i] = mt[i + (.MM - .NN)] ^ (x >> 1) ^ magic(x)
                i += 1
            }

            x = (mt[.NN - 1] & .UM) | (mt[0] & .LM)
            mt[.NN - 1] = mt[.MM - 1] ^ (x >> 1) ^ magic(x)

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

/*

 /* This is the original implementation. It is replaced by the alternate implementation, below. */
     int i;
     unsigned long long x;
     static unsigned long long mag01[2]={0ULL, MATRIX_A};

     if (mti >= NN) { /* generate NN words at one time */

         /* if init_genrand64() has not been called, */
         /* a default initial seed is used     */
         if (mti == NN+1)
             init_genrand64(5489ULL);

         for (i=0;i<NN-MM;i++) {
             x = (mt[i]&UM)|(mt[i+1]&LM);
             mt[i] = mt[i+MM] ^ (x>>1) ^ mag01[(int)(x&1ULL)];
         }
         for (;i<NN-1;i++) {
             x = (mt[i]&UM)|(mt[i+1]&LM);
             mt[i] = mt[i+(MM-NN)] ^ (x>>1) ^ mag01[(int)(x&1ULL)];
         }
         x = (mt[NN-1]&UM)|(mt[0]&LM);
         mt[NN-1] = mt[MM-1] ^ (x>>1) ^ mag01[(int)(x&1ULL)];

         mti = 0;
     }

     x = mt[mti++];

     x ^= (x >> 29) & 0x5555555555555555ULL;
     x ^= (x << 17) & 0x71D67FFFEDA60000ULL;
     x ^= (x << 37) & 0xFFF7EEE000000000ULL;
     x ^= (x >> 43);

     return x;

 */

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
