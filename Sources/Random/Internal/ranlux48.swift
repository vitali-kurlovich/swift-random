//
//  ranlux48.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 31.03.25.
//

@usableFromInline
struct rand48_state_t {
    @usableFromInline
    var x0: UInt16 = 0
    @usableFromInline
    var x1: UInt16 = 0
    @usableFromInline
    var x2: UInt16 = 0
}

extension rand48_state_t {
    @inlinable
    @inline(__always)
    mutating func rand48_set(s: UInt64) {
        if s == 0 {
            x0 = 0x330E
            x1 = 0xABCD
            x2 = 0x1234
        } else {
            x0 = 0x330E
            x1 = UInt16(truncatingIfNeeded: s & 0xFFFF)
            x2 = UInt16(truncatingIfNeeded: (s >> 16) & 0xFFFF)
        }
    }

    @inline(__always)
    mutating func rand48_get() -> UInt64 {
        rand48_advance()

        let x1 = UInt64(self.x1)
        let x2 = UInt64(self.x2)

        return (x2 << 16) + x1
    }

    @inline(__always)
    private mutating func rand48_advance() {
        let x0 = UInt64(self.x0)
        let x1 = UInt64(self.x1)
        let x2 = UInt64(self.x2)

        var a: UInt64 = 0xE66D * x0 + 0x000B
        self.x0 = UInt16(truncatingIfNeeded: a & 0xFFFF)

        a >>= 16
        a += 0xE66D * x1 + 0xDEEC * x0
        self.x1 = UInt16(truncatingIfNeeded: a & 0xFFFF)

        a >>= 16
        a += 0xE66D * x2 + 0xDEEC * x1 + 0x0005 * x0
        self.x2 = UInt16(truncatingIfNeeded: a & 0xFFFF)
    }
}
