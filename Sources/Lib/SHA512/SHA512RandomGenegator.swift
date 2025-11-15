//
//  SHA512RandomGenegator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import struct Crypto.SHA512
import Foundation

/// RandomNumberGenerator
public struct SHA512RandomGenegator: RandomNumberGenerator {
    typealias Hash = SHA512
    typealias Digest = Hash.Digest

    private var digest: Digest
    private var offset: Int

    public mutating func next() -> UInt64 {
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
}

// MARK: - Init

public extension SHA512RandomGenegator {
    init(seed: UInt64) {
        var seed = seed

        let data = Data(bytes: &seed,
                        count: MemoryLayout.size(ofValue: seed))

        self.init(data)
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

        let data = Data(bytes)
        self.init(data)
    }

    init(_ data: some DataProtocol) {
        var hash = Hash()
        hash.update(data: data)
        let digest = hash.finalize()
        self.init(digest: digest, offset: 0)
    }
}

// MARK: - Private

private extension SHA512RandomGenegator {
    mutating func invalidateDigits() {
        var hash = Hash()
        digest.withUnsafeBytes { bufferPointer in
            hash.update(bufferPointer: bufferPointer)
        }

        digest = hash.finalize()
        offset = 0
    }
}
