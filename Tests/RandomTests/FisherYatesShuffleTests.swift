//
//  FisherYatesShuffleTests.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 18.09.25.
//

import Random
import Testing

struct FisherYatesShuffle {
    @Test("Shuffle")
    func shuffleArray() {
        var array: [Int] = [1, 2, 3, 4, 5]
        var generator = MT19937RandomGenegator(seed: 1234)
        array.shuffle(algorithm: .default, using: &generator)
        #expect(array == [5, 2, 1, 3, 4])

        generator = MT19937RandomGenegator(seed: 1234)
        #expect([1, 2, 3, 4, 5].shuffled(algorithm: .default, using: &generator) == [5, 2, 1, 3, 4])
    }

    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
    @Test("Shuffle InlineArray")
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

    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
    @Test("Shuffle InlineArray")
    func shuffleInlineArrayWithRandoms() {
        var generator = MT19937RandomGenegator(seed: 1234)
        var array: InlineArray = [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
            11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
            21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
            31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
            41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
            51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
            61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
            71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
            81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
            91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
        ]

        array.shuffle(algorithm: .default, using: &generator)

        let expected = [
            95, 7, 98, 1, 22, 96, 89, 4, 17,
            78, 6, 21, 55, 3, 25, 81, 20, 23,
            36, 73, 37, 100, 46, 93, 31, 75, 9,
            29, 43, 87, 85, 33, 72, 77, 70, 61,
            59, 84, 74, 90, 54, 86, 14, 94, 63,
            65, 64, 50, 15, 8, 11, 42, 53, 88, 62,
            67, 35, 13, 56, 44, 38, 19, 30, 79, 40,
            68, 5, 83, 99, 71, 66, 80, 10, 82, 69, 58,
            34, 92, 47, 41, 27, 91, 48, 57, 18, 76, 26,
            24, 49, 60, 52, 39, 32, 45, 12, 51, 97, 16, 28, 2,
        ]

        for (index, value) in expected.enumerated() {
            #expect(array[index] == value)
        }
    }
}
