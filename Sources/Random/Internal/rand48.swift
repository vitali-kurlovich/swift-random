//
//  rand48.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 31.03.25.
//

private let a0: UInt64 = 0xE66D
private let a1: UInt64 = 0xDEEC
private let a2: UInt64 = 0x0005

private let c0: UInt64 = 0x000B

struct rand48_state_t {
    var x0: UInt16
    var x1: UInt16
    var x2: UInt16
}

typealias vstate = rand48_state_t

func rand48_set(state: inout vstate, s: UInt64) {
    if s == 0 {
        state.x0 = 0x330E
        state.x1 = 0xABCD
        state.x2 = 0x1234
    } else {
        state.x0 = 0x330E
        state.x1 = UInt16(truncatingIfNeeded: s & 0xFFFF)
        state.x2 = UInt16(truncatingIfNeeded: (s >> 16) & 0xFFFF)
    }
}

func rand48_advance(state: inout vstate) {
    let x0 = UInt64(state.x0)
    let x1 = UInt64(state.x1)
    let x2 = UInt64(state.x2)

    var a = a0 * x0 + c0
    state.x0 = UInt16(truncatingIfNeeded: a & 0xFFFF)

    a >>= 16
    a += a0 * x1 + a1 * x0
    state.x1 = UInt16(truncatingIfNeeded: a & 0xFFFF)

    a >>= 16
    a += a0 * x2 + a1 * x1 + a2 * x0
    state.x2 = UInt16(truncatingIfNeeded: a & 0xFFFF)
}

func rand48_get(state: inout vstate) -> UInt64 {
    rand48_advance(state: &state)

    let x1 = UInt64(state.x1)
    let x2 = UInt64(state.x2)

    return (x2 << 16) + x1
}

/*

 static unsigned long int
 rand48_get (void *vstate)
 {
   unsigned long int x1, x2;

   rand48_state_t *state = (rand48_state_t *) vstate;
   rand48_advance (state) ;

   x2 = (unsigned long int) state->x2;
   x1 = (unsigned long int) state->x1;

   return (x2 << 16) + x1;
 }

 */
