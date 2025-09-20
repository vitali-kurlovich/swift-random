//
//  ShuffleTests.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 21.09.25.
//

import Random
import Testing

struct ShuffleSmall {
    @Test("Shuffle Empty")
    func shuffleEmpty() {
        var generator = MT19937RandomGenegator(seed: 42)

        var array: [Int] = []
        array.shuffle(algorithm: .default, using: &generator)
        #expect(array == [])

        array.shuffle(algorithm: .faro(.init(count: 10)), using: &generator)
        #expect(array == [])
    }

    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
    @Test("Shuffle Empty InlineArray")
    func shuffleEmptyInlineArray() {
        var generator = MT19937RandomGenegator(seed: 42)
        var array: InlineArray<_, Int> = []
        array.shuffle(algorithm: .default, using: &generator)
        #expect(array.isEmpty)

        array.shuffle(algorithm: .faro(.init(count: 10)), using: &generator)
        #expect(array.isEmpty)
    }

    @Test("Shuffled Empty")
    func shuffledEmpty() {
        var generator = MT19937RandomGenegator(seed: 42)

        #expect([Int]().shuffled(algorithm: .default, using: &generator) == [])
        #expect([Int]().shuffled(algorithm: .faro(.init(count: 10)), using: &generator) == [])

        #expect(EmptyCollection<Int>().shuffled(algorithm: .default, using: &generator) == [])
        #expect(EmptyCollection<Int>().shuffled(algorithm: .faro(.init(count: 10)), using: &generator) == [])
    }

    @Test("Shuffle One")
    func shuffleOne() {
        var generator = MT19937RandomGenegator(seed: 42)
        var array = [12]
        array.shuffle(algorithm: .default, using: &generator)
        #expect(array == [12])

        array.shuffle(algorithm: .faro(.init(count: 10)), using: &generator)
        #expect(array == [12])
    }

    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
    @Test("Shuffle One InlineArray")
    func shuffleOneInlineArray() {
        var generator = MT19937RandomGenegator(seed: 42)

        var inlineArray: InlineArray = [16]

        inlineArray.shuffle(algorithm: .default, using: &generator)
        #expect(inlineArray[0] == 16)

        inlineArray.shuffle(algorithm: .faro(.init(count: 10)), using: &generator)
        #expect(inlineArray[0] == 16)
    }

    @Test("Shuffled One")
    func shuffledOne() {
        var generator = MT19937RandomGenegator(seed: 42)

        #expect([12].shuffled(algorithm: .default, using: &generator) == [12])
        #expect([12].shuffled(algorithm: .faro(.init(count: 10)), using: &generator) == [12])

        #expect(CollectionOfOne(12).shuffled(algorithm: .default, using: &generator) == [12])
        #expect(CollectionOfOne(12).shuffled(algorithm: .faro(.init(count: 10)), using: &generator) == [12])
    }
}
