//
//  FixedSizeBuffer.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 4.04.25.
//

@usableFromInline
final class FixedSizeBuffer<Element: BitwiseCopyable> {
    @usableFromInline
    let count: Int

    private let buffer: UnsafeMutableRawBufferPointer

    @usableFromInline
    init(count: Int) {
        self.count = count
        let elementSize = MemoryLayout<Element>.size
        buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: elementSize * count, alignment: 0)
    }

    deinit {
        buffer.deallocate()
    }
}

extension FixedSizeBuffer {
    convenience init<S: Collection>(_ collection: S) where S.Element == Element {
        let count = collection.count

        self.init(count: count)

        var index = 0

        for element in collection {
            self[index] = element
            index += 1
        }
    }
}

extension FixedSizeBuffer {
    @usableFromInline
    subscript(index: Int) -> Element {
        get {
            assert((0 ..< count).contains(index))
            let offsetPointer = buffer.baseAddress! + MemoryLayout<Element>.size * index
            return offsetPointer.load(as: Element.self)
        }
        set(newValue) {
            assert((0 ..< count).contains(index))
            let byteOffset = MemoryLayout<Element>.size * index
            buffer.baseAddress!.storeBytes(of: newValue, toByteOffset: byteOffset, as: Element.self)
        }
    }
}

extension FixedSizeBuffer: Equatable where Element: Equatable {
    @usableFromInline
    static func == (lhs: FixedSizeBuffer<Element>, rhs: FixedSizeBuffer<Element>) -> Bool {
        return lhs === rhs || isEqual(left: lhs, right: rhs)
    }

    private static func isEqual(left: FixedSizeBuffer<Element>, right: FixedSizeBuffer<Element>) -> Bool {
        guard left.count == right.count else { return false }

        for index in 0 ..< left.count {
            if left[index] != right[index] {
                return false
            }
        }

        return true
    }
}
