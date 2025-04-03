//
//  mt19937.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 2.04.25.
//

/*

 #define N 624   /* Period parameters */
 #define M 397

 /* most significant w-r bits */
 static const unsigned long UPPER_MASK = 0x80000000UL;

 /* least significant r bits */
 static const unsigned long LOWER_MASK = 0x7fffffffUL;

 typedef struct
   {
     unsigned long mt[N];
     int mti;
   }
 mt_state_t;

 */

private let N: Int = 624
private let M: Int = 397

private let UPPER_MASK: UInt32 = 0x8000_0000
private let LOWER_MASK: UInt32 = 0x7FFF_FFFF

struct mt_state_t: Equatable {
    var mt: [UInt32] = Array(repeating: 0, count: Int(N))
    var mti: Int = 0
}

func mt_set(state: inout mt_state_t, s: UInt32) {
    let s = s == 0 ? 4357 : s

    state.mt[0] = s & 0xFFFF_FFFF

    for i in 1 ..< N {
        let mt = UInt64(state.mt[i - 1])
        let hash = (1_812_433_253 * (mt ^ (mt >> 30)) + UInt64(i)) & 0xFFFF_FFFF
        state.mt[i] = UInt32(truncatingIfNeeded: hash)
    }
    state.mti = N
}

func mt_get(state: inout mt_state_t) -> UInt32 {
    func magic<B: BinaryInteger>(_ y: B) -> B {
        (y & 0x1) != 0 ? 0x9908_B0DF : 0
    }

    if state.mti >= N {
        var kk = 0
        while kk < N - M {
            let y = (state.mt[kk] & UPPER_MASK) | (state.mt[kk + 1] & LOWER_MASK)
            state.mt[kk] = state.mt[kk + M] ^ (y >> 1) ^ magic(y)
            kk += 1
        }

        while kk < N - 1 {
            let y = (state.mt[kk] & UPPER_MASK) | (state.mt[kk + 1] & LOWER_MASK)
            state.mt[kk] = state.mt[kk + (M - N)] ^ (y >> 1) ^ magic(y)
            kk += 1
        }

        let y = (state.mt[N - 1] & UPPER_MASK) | (state.mt[0] & LOWER_MASK)
        state.mt[N - 1] = state.mt[M - 1] ^ (y >> 1) ^ magic(y)

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

/*

 static inline unsigned long
 mt_get (void *vstate)
 {
   mt_state_t *state = (mt_state_t *) vstate;

   unsigned long k ;
   unsigned long int *const mt = state->mt;

 #define MAGIC(y) (((y)&0x1) ? 0x9908b0dfUL : 0)

   if (state->mti >= N)
     {   /* generate N words at one time */
       int kk;

       for (kk = 0; kk < N - M; kk++)
         {
           unsigned long y = (mt[kk] & UPPER_MASK) | (mt[kk + 1] & LOWER_MASK);
           mt[kk] = mt[kk + M] ^ (y >> 1) ^ MAGIC(y);
         }
       for (; kk < N - 1; kk++)
         {
           unsigned long y = (mt[kk] & UPPER_MASK) | (mt[kk + 1] & LOWER_MASK);
           mt[kk] = mt[kk + (M - N)] ^ (y >> 1) ^ MAGIC(y);
         }

       {
         unsigned long y = (mt[N - 1] & UPPER_MASK) | (mt[0] & LOWER_MASK);
         mt[N - 1] = mt[M - 1] ^ (y >> 1) ^ MAGIC(y);
       }

       state->mti = 0;
     }

   /* Tempering */

   k = mt[state->mti];
   k ^= (k >> 11);
   k ^= (k << 7) & 0x9d2c5680UL;
   k ^= (k << 15) & 0xefc60000UL;
   k ^= (k >> 18);

   state->mti++;

   return k;
 }

 */
