//
//  PasteboardWatcher.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 15.11.25.
//

#if canImport(UIKit)
    import UIKit
#endif

#if canImport(AppKit)
    import AppKit
#endif

import Combine

final class PasteboardWatcher: ObservableObject {
    let objectWillChange: ObservableObjectPublisher
    let pasteboard: Pasteboard

    private var timer: Timer!
    private var changeCount: Int {
        didSet {
            if oldValue != changeCount {
                objectWillChange.send()
            }
        }
    }

    init(_ pasteboard: Pasteboard = .general) {
        objectWillChange = .init()
        self.pasteboard = pasteboard
        changeCount = pasteboard.changeCount

        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            self?.changeCount = pasteboard.changeCount
        }
    }
}
