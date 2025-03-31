//
//  rand48.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 31.03.25.
//

@usableFromInline
struct rand48_state_t {
    @usableFromInline
    var x0: UInt16
    @usableFromInline
    var x1: UInt16
    @usableFromInline
    var x2: UInt16
}

@inlinable
@inline(__always)
func rand48_set(state: inout rand48_state_t, s: UInt64) {
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

@inlinable
@inline(__always)
func rand48_advance(state: inout rand48_state_t) {
    let x0 = UInt64(state.x0)
    let x1 = UInt64(state.x1)
    let x2 = UInt64(state.x2)

    var a: UInt64 = 0x000B
    a += 0xE66D * x0
    state.x0 = UInt16(truncatingIfNeeded: a & 0xFFFF)

    a >>= 16
    a += 0xE66D * x1 + 0xDEEC * x0
    state.x1 = UInt16(truncatingIfNeeded: a & 0xFFFF)

    a >>= 16
    a += 0xE66D * x2 + 0xDEEC * x1 + 0x0005 * x0
    state.x2 = UInt16(truncatingIfNeeded: a & 0xFFFF)
}

@inlinable
@inline(__always)
func rand48_get(state: inout rand48_state_t) -> UInt64 {
    rand48_advance(state: &state)

    let x1 = UInt64(state.x1)
    let x2 = UInt64(state.x2)

    return (x2 << 16) + x1
}
