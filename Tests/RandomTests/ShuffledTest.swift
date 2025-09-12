//
//  ShuffledTest.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

import Random
import Testing

@Test("Shuffle empty")
func shuffleEmpty() {
    var array: [Int] = []
    var generator = MT19937RandomGenegator(seed: 0)
    array.shuffle(algorithm: .default, using: &generator)
    #expect(array == [])

    array.shuffle(algorithm: .faro, using: &generator)
    #expect(array == [])

    #expect([Int]().shuffled(algorithm: .default, using: &generator) == [])
    #expect(EmptyCollection<Int>().shuffled(algorithm: .default, using: &generator) == [])

    #expect([Int]().shuffled(algorithm: .faro, using: &generator) == [])
    #expect(EmptyCollection<Int>().shuffled(algorithm: .faro, using: &generator) == [])
}

@Test("Shuffle One")
func shuffleOne() {
    var generator = MT19937RandomGenegator(seed: 0)
    var array = [12]
    array.shuffle(algorithm: .default, using: &generator)
    #expect(array == [12])
    array.shuffle(algorithm: .faro, using: &generator)
    #expect(array == [12])

    #expect(CollectionOfOne(12).shuffled(algorithm: .default, using: &generator) == [12])
    #expect(CollectionOfOne(12).shuffled(algorithm: .faro, using: &generator) == [12])
}

@Test("Shuffle (Fisher Yates)")
func shuffleArrayFisherYates() {
    var array: [Int] = [1, 2, 3, 4, 5]
    var generator = MT19937RandomGenegator(seed: 1234)
    array.shuffle(algorithm: .default, using: &generator)

    #expect(array == [5, 2, 1, 3, 4])

    generator = MT19937RandomGenegator(seed: 1234)
    #expect([1, 2, 3, 4, 5].shuffled(algorithm: .default, using: &generator) == [5, 2, 1, 3, 4])
}

@Test("Shuffle (faro)")
func shuffleArrayFaro() {
    var array: [Int] = [1, 2, 3, 4, 5, 6]
    var generator = MT19937RandomGenegator(seed: 1234)
    array.shuffle(algorithm: .faro, using: &generator)

    #expect(array == [1, 4, 2, 5, 3, 6])

    generator = MT19937RandomGenegator(seed: 1234)
    #expect([1, 2, 3, 4, 5, 6].shuffled(algorithm: .faro, using: &generator) == [1, 4, 2, 5, 3, 6])

    generator = MT19937RandomGenegator(seed: 1234)
    array = [1, 2, 3, 4, 5]
    array.shuffle(algorithm: .faro, using: &generator)
    #expect(array == [1, 3, 2, 4, 5])

    generator = MT19937RandomGenegator(seed: 1234)
    #expect([1, 2, 3, 4, 5].shuffled(algorithm: .faro, using: &generator) == [1, 3, 2, 4, 5])
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
@Test("Shuffle One InlineArray")
func shuffleOneInlineArray() {
    var generator = MT19937RandomGenegator(seed: 0)

    var inlineArray: InlineArray = [16]

    inlineArray.shuffle(algorithm: .default, using: &generator)
    #expect(inlineArray.count == 1)
    #expect(inlineArray[0] == 16)
}

@available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
@Test("Shuffle InlineArray (Fisher Yates)")
func shuffleInlineArray() {
    var array: InlineArray = [1, 2, 3, 4, 5]

    var generator = MT19937RandomGenegator(seed: 1234)
    array.shuffle(algorithm: .default, using: &generator)

    let expected: InlineArray = [5, 2, 1, 3, 4]

    #expect(array.count == expected.count)

    #expect(array[0] == expected[0])
    #expect(array[1] == expected[1])
    #expect(array[2] == expected[2])
    #expect(array[3] == expected[3])
    #expect(array[4] == expected[4])

    generator = MT19937RandomGenegator(seed: 1234)
    let newArray: InlineArray = [1, 2, 3, 4, 5]

    let copy = newArray.shuffled(algorithm: .default, using: &generator)

    #expect(copy.count == expected.count)

    #expect(copy[0] == expected[0])
    #expect(copy[1] == expected[1])
    #expect(copy[2] == expected[2])
    #expect(copy[3] == expected[3])
    #expect(copy[4] == expected[4])
}
