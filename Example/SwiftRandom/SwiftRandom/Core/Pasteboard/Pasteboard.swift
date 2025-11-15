//
//  Pasteboard.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 15.11.25.
//

import struct Foundation.UUID

#if canImport(UIKit)
    import class UIKit.UIPasteboard

    typealias Pasteboard = UIPasteboard
#endif

#if canImport(AppKit)
    import class AppKit.NSPasteboard

    typealias Pasteboard = NSPasteboard
#endif

extension Pasteboard {
    var uuid: UUID? {
        get {
            #if canImport(AppKit)

                guard let string = string(forType: .string) else {
                    return nil
                }

            #endif // canImport(AppKit)

            #if canImport(UIKit)
                guard let string = self.string else { return nil }
            #endif

            return UUID(uuidString: string)
        }

        set {
            #if canImport(AppKit)
                clearContents()
            #endif

            guard let uuid = newValue else { return }

            #if canImport(AppKit)
                setString(uuid.uuidString, forType: .string)
            #endif

            #if canImport(UIKit)
                string = uuid.uuidString
            #endif
        }
    }
}
