//
//  CryptoRandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import Crypto
import Foundation

public
struct CryptoRandomGenegator: RandomNumberGenerator {
    typealias Hash = SHA512
    typealias Digest = Hash.Digest

    private var digest: Digest
    private var offset: Int = 0

    init(bufferPointer: UnsafeRawBufferPointer) {
        var hash = Hash()
        hash.update(bufferPointer: bufferPointer)
        digest = hash.finalize()
    }

    public
    mutating func next() -> UInt64 {
        let n = MemoryLayout<UInt64>.size

        if offset + n > Digest.byteCount {
            invalidateDigits()
        }

        var v: UInt64 = 0

        digest.withUnsafeBytes { bufferPointer in
            v = bufferPointer.load(fromByteOffset: offset, as: UInt64.self).littleEndian
        }

        offset += n

        return v
    }

    private
    mutating func invalidateDigits() {
        var hash = Hash()
        digest.withUnsafeBytes { bufferPointer in
            hash.update(bufferPointer: bufferPointer)
        }

        digest = hash.finalize()
        offset = 0
    }
}

public extension CryptoRandomGenegator {
    init(seed: UInt64 = 0) {
        var v = seed.littleEndian
        let n = MemoryLayout<UInt64>.size

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: n, alignment: 0)

        defer {
            buffer.deallocate()
        }

        buffer.baseAddress?.copyMemory(from: &v, byteCount: n)

        self.init(bufferPointer: .init(buffer))
    }

    init(uuid: UUID = UUID()) {
        let uuid = uuid.uuid
        let bytes: [UInt8] = [
            uuid.0,
            uuid.1,
            uuid.2,
            uuid.3,
            uuid.4,
            uuid.5,
            uuid.6,
            uuid.7,
            uuid.8,
            uuid.9,
            uuid.10,
            uuid.11,
            uuid.12,
            uuid.13,
            uuid.14,
            uuid.15,
        ]

        let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: bytes.count, alignment: 0)

        defer {
            buffer.deallocate()
        }

        buffer.copyBytes(from: bytes)

        self.init(bufferPointer: .init(buffer))
    }
}
