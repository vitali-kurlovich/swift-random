//
//  UUID+UTType.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 9.10.25.
//

import CoreTransferable
import struct Foundation.UUID
internal import UniformTypeIdentifiers

extension UUID: @retroactive Transferable {
    enum TransferableError: Error {
        case invalidData
        case invalidTextFormat
    }

    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(contentType: .uuid) { uuid in
            uuid.data
        } importing: { data in
            guard let uuid = UUID(data: data) else {
                throw TransferableError.invalidData
            }
            return uuid
        }

        ProxyRepresentation(exporting: { uuid in
            uuid.uuidString
        }) { string in
            guard let uuid = UUID(uuidString: string) else {
                throw TransferableError.invalidTextFormat
            }
            return uuid
        }
    }
}

extension UTType {
    static var uuid: UTType {
        UTType(exportedAs: "random.uuid")
    }
}
