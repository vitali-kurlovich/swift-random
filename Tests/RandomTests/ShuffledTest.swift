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
    var generator = MT19937RandomGenegator(seed: 42)

    array.shuffle(algorithm: .default, using: &generator)
    #expect(array == [])

    let configuration = FaroShuffleConfiguration(count: 1)
    array.shuffle(algorithm: .faro(configuration), using: &generator)
    #expect(array == [])

    #expect([Int]().shuffled(algorithm: .default, using: &generator) == [])
    #expect(EmptyCollection<Int>().shuffled(algorithm: .default, using: &generator) == [])

    #expect([Int]().shuffled(algorithm: .faro(configuration), using: &generator) == [])
    #expect(EmptyCollection<Int>().shuffled(algorithm: .faro(configuration), using: &generator) == [])
}

@Test("Shuffle One")
func shuffleOne() {
    var generator = MT19937RandomGenegator(seed: 0)
    var array = [12]
    array.shuffle(algorithm: .default, using: &generator)
    #expect(array == [12])

    let configuration = FaroShuffleConfiguration(count: 1)
    array.shuffle(algorithm: .faro(configuration), using: &generator)
    #expect(array == [12])

    #expect(CollectionOfOne(12).shuffled(algorithm: .default, using: &generator) == [12])
    #expect(CollectionOfOne(12).shuffled(algorithm: .faro(configuration), using: &generator) == [12])
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
    var generator = MT19937RandomGenegator(seed: 42) // false, true, true, false, true, false, true, true, false, true
    array.shuffle(algorithm: .faro(.init(count: 1)), using: &generator)
    #expect(array == [4, 1, 5, 2, 6, 3])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6]
    array.shuffle(algorithm: .faro(.init(count: 2)), using: &generator)
    #expect(array == [4, 2, 1, 6, 5, 3])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6]
    array.shuffle(algorithm: .faro(.init(count: 3)), using: &generator)
    #expect(array == [4, 6, 2, 5, 1, 3])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6]
    array.shuffle(algorithm: .faro(.init(count: 4)), using: &generator)
    #expect(array == [5, 4, 1, 6, 3, 2])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6]
    array.shuffle(algorithm: .faro(.init(count: 5)), using: &generator)
    #expect(array == [5, 6, 4, 3, 1, 2])

    // [1, 2, 3, 4, 5, 6] : [1, 2, 3] | [4, 5, 6] -> [4, 1, 5, 2, 6, 3]
    // [4, 1, 5, 2, 6, 3] : [4, 1, 5] | [2, 6, 3] -> [4, 2, 1, 6, 5, 3]
    // [4, 2, 1, 6, 5, 3] : [4, 2, 1] | [6, 5, 3] -> [4, 6, 2, 5, 1, 3]
    // [4, 6, 2, 5, 1, 3] : [4, 6, 2] | [5, 1, 3] -> [5, 4, 1, 6, 3, 2]
    // [5, 4, 1, 6, 3, 2] : [5, 4, 1] | [6, 3, 2] -> [5, 6, 4, 3, 1, 2]

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6, 7]
    array.shuffle(algorithm: .faro(.init(count: 1)), using: &generator)
    #expect(array == [4, 1, 5, 2, 6, 3, 7])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6, 7]
    array.shuffle(algorithm: .faro(.init(count: 2)), using: &generator)
    #expect(array == [4, 6, 1, 3, 5, 7, 2])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6, 7]
    array.shuffle(algorithm: .faro(.init(count: 3)), using: &generator)
    #expect(array == [4, 5, 6, 7, 1, 2, 3])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6, 7]
    array.shuffle(algorithm: .faro(.init(count: 4)), using: &generator)
    #expect(array == [7, 4, 1, 5, 2, 6, 3])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6, 7]
    array.shuffle(algorithm: .faro(.init(count: 5)), using: &generator)
    #expect(array == [7, 2, 4, 6, 1, 3, 5])

    generator = MT19937RandomGenegator(seed: 42)
    array = [1, 2, 3, 4, 5, 6, 7]
    array.shuffle(algorithm: .faro(.init(count: 6)), using: &generator)
    #expect(array == [6, 7, 1, 2, 3, 4, 5])

    // [1, 2, 3, 4, 5, 6, 7] : [1, 2, 3]    | [4, 5, 6, 7] -> [4, 1, 5, 2, 6, 3, 7]
    // [4, 1, 5, 2, 6, 3, 7] : [4, 1, 5, 2] | [6, 3, 7]    -> [4, 6, 1, 3, 5, 7, 2]
    // [4, 6, 1, 3, 5, 7, 2] : [4, 6, 1, 3] | [5, 7, 2]    -> [4, 5, 6, 7, 1, 2, 3]
    // [4, 5, 6, 7, 1, 2, 3] : [4, 5, 6]    | [7, 1, 2, 3] -> [7, 4, 1, 5, 2, 6, 3]
    // [7, 4, 1, 5, 2, 6, 3] : [7, 4, 1, 5] | [2, 6, 3]    -> [7, 2, 4, 6, 1, 3, 5]
    // [7, 2, 4, 6, 1, 3, 5] : [7, 2, 4]    | [6, 1, 3, 5] -> [6, 7, 1, 2, 3, 4, 5]
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
