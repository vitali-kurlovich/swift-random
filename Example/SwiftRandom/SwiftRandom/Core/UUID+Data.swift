//
//  UUID+Data.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 10.10.25.
//

import Foundation

extension UUID {
    nonisolated init?(data: Data) {
        guard data.count == 16 else {
            return nil
        }
        let uuid = data.bytes.unsafeLoad(as: uuid_t.self)
        self.init(uuid: uuid)
    }

    nonisolated var data: Data {
        withUnsafeBytes(of: uuid) { Data($0) }
    }
}
