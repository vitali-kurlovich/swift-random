//
//  FaroShuffleTest.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

import Random
import Testing

struct FaroShuffle {
    @Test("Shuffle empty")
    func shuffleEmpty() {
        var generator = MT19937RandomGenegator(seed: 42)
        let configuration = FaroShuffleConfiguration(count: 3)

        var array: [Int] = []
        array.shuffle(algorithm: .faro(configuration), using: &generator)
        #expect(array == [])

        #expect([Int]().shuffled(algorithm: .faro(configuration), using: &generator) == [])
        #expect(EmptyCollection<Int>().shuffled(algorithm: .faro(configuration), using: &generator) == [])
    }

    @Test("Shuffle One")
    func shuffleOne() {
        var generator = MT19937RandomGenegator(seed: 42)
        let configuration = FaroShuffleConfiguration(count: 3)

        var array = [12]
        array.shuffle(algorithm: .faro(configuration), using: &generator)
        #expect(array == [12])

        #expect([12].shuffled(algorithm: .faro(configuration), using: &generator) == [12])
        #expect(CollectionOfOne(12).shuffled(algorithm: .faro(configuration), using: &generator) == [12])
    }

    @Test("Shuffle")
    func shuffleArray() {
        var array = [1, 2, 3, 4, 5, 6]
        var generator = MT19937RandomGenegator(seed: 42) // false, true, true, false, true, false, true, true, false, true

        var configuration = FaroShuffleConfiguration(count: 5, middleShiftRange: 0 ... 0, stuckCardsRange: 1 ... 1)

        array = [1, 2, 3, 4, 5, 6]
        array.shuffle(algorithm: .faro(configuration), using: &generator)

        // [1, 2, 3, 4, 5, 6] : [1, 2, 3] | [4, 5, 6] -> [4, 1, 5, 2, 6, 3]
        // [4, 1, 5, 2, 6, 3] : [4, 1, 5] | [2, 6, 3] -> [4, 2, 1, 6, 5, 3]
        // [4, 2, 1, 6, 5, 3] : [4, 2, 1] | [6, 5, 3] -> [4, 6, 2, 5, 1, 3]
        // [4, 6, 2, 5, 1, 3] : [4, 6, 2] | [5, 1, 3] -> [5, 4, 1, 6, 3, 2]
        // [5, 4, 1, 6, 3, 2] : [5, 4, 1] | [6, 3, 2] -> [5, 6, 4, 3, 1, 2]

        #expect(array == [5, 6, 4, 3, 1, 2])

        generator = MT19937RandomGenegator(seed: 42)
        array = [1, 2, 3, 4, 5, 6, 7]

        configuration.count = 6

        array.shuffle(algorithm: .faro(configuration), using: &generator)

        // [1, 2, 3, 4, 5, 6, 7] : [1, 2, 3]    | [4, 5, 6, 7] -> [4, 1, 5, 2, 6, 3, 7]
        // [4, 1, 5, 2, 6, 3, 7] : [4, 1, 5, 2] | [6, 3, 7]    -> [4, 6, 1, 3, 5, 7, 2]
        // [4, 6, 1, 3, 5, 7, 2] : [4, 6, 1, 3] | [5, 7, 2]    -> [4, 5, 6, 7, 1, 2, 3]
        // [4, 5, 6, 7, 1, 2, 3] : [4, 5, 6]    | [7, 1, 2, 3] -> [7, 4, 1, 5, 2, 6, 3]
        // [7, 4, 1, 5, 2, 6, 3] : [7, 4, 1, 5] | [2, 6, 3]    -> [7, 2, 4, 6, 1, 3, 5]
        // [7, 2, 4, 6, 1, 3, 5] : [7, 2, 4]    | [6, 1, 3, 5] -> [6, 7, 1, 2, 3, 4, 5]

        #expect(array == [6, 7, 1, 2, 3, 4, 5])
    }

    @Test("Shuffle stuck cards")
    func shuffleArrayStuckCards() {
        var generator = MT19937RandomGenegator(seed: 42) // false, true, true, false, true, false, true, true, false, true
        let configuration = FaroShuffleConfiguration(count: 4, middleShiftRange: 0 ... 0, stuckCardsRange: 2 ... 2)

        var array = [1, 2, 3, 4, 5, 6]
        array.shuffle(algorithm: .faro(configuration), using: &generator)

        // [1, 2, 3, 4, 5, 6] : [1, 2, 3] | [4, 5, 6] -> [4, 5, 1, 2, 6, 3]
        // [4, 5, 1, 2, 6, 3] : [4, 5, 1] | [2, 6, 3] -> [4, 5, 2, 6, 1, 3]
        // [4, 5, 2, 6, 1, 3] : [4, 5, 2] | [6, 1, 3] -> [4, 5, 6, 1, 2, 3]
        // [4, 5, 6, 1, 2, 3] : [4, 5, 6] | [1, 2, 3] -> [1, 2, 4, 5, 3, 6]

        #expect(array == [1, 2, 4, 5, 3, 6])

        generator = MT19937RandomGenegator(seed: 42)
        array = [1, 2, 3, 4, 5, 6, 7]
        array.shuffle(algorithm: .faro(configuration), using: &generator)
        // [1, 2, 3, 4, 5, 6, 7] : [1, 2, 3]    | [4, 5, 6, 7] -> [4, 5, 1, 2, 6, 7, 3]
        // [4, 5, 1, 2, 6, 7, 3] : [4, 5, 1, 2] | [6, 7, 3]    -> [4, 5, 6, 7, 1, 2, 3]
        // [4, 5, 6, 7, 1, 2, 3] : [4, 5, 6, 7] | [1, 2, 3]    -> [4, 5, 1, 2, 6, 7, 3]
        // [4, 5, 1, 2, 6, 7, 3] : [4, 5, 1]    | [2, 6, 7, 3] -> [2, 6, 4, 5, 7, 3, 1]

        #expect(array == [2, 6, 4, 5, 7, 3, 1])
    }

    @Test("Shuffle middle shift")
    func shuffleArrayMiddleShift() {
        var generator = MT19937RandomGenegator(seed: 42) // false, true, true, false, true, false, true, true, false, true
        let configuration = FaroShuffleConfiguration(count: 4, middleShiftRange: 1 ... 1, stuckCardsRange: 1 ... 1)

        var array = [1, 2, 3, 4, 5, 6]
        array.shuffle(algorithm: .faro(configuration), using: &generator)

        // [1, 2, 3, 4, 5, 6] : [1, 2, 3, 4] | [ 5, 6] -> [1, 5, 2, 6, 3, 4]
        // [1, 5, 2, 6, 3, 4] : [1, 5, 2, 6] | [ 3, 4] -> [1, 3, 5, 4, 2, 6]
        // [1, 3, 5, 4, 2, 6] : [1, 3, 5, 4] | [ 2, 6] -> [1, 2, 3, 6, 5, 4]
        // [1, 2, 3, 6, 5, 4] : [1, 2, 3, 6] | [ 5, 4] -> [1, 5, 2, 4, 3, 6]

        #expect(array == [1, 5, 2, 4, 3, 6])

        generator = MT19937RandomGenegator(seed: 42)
        array = [1, 2, 3, 4, 5, 6, 7]
        array.shuffle(algorithm: .faro(configuration), using: &generator)

        // [1, 2, 3, 4, 5, 6, 7] : [1, 2, 3, 4]     | [ 5, 6, 7] -> [1, 5, 2, 6, 3, 7, 4]
        // [1, 5, 2, 6, 3, 7, 4] : [1, 5, 2, 6, 3]  | [ 7, 4]    -> [1, 7, 5, 4, 2, 6, 3]
        // [1, 7, 5, 4, 2, 6, 3] : [1, 7, 5, 4, 2]  | [ 6, 3]    -> [1, 6, 7, 3, 5, 4, 2]
        // [1, 6, 7, 3, 5, 4, 2] : [1, 6, 7, 3]     | [ 5, 4, 2] -> [1, 5, 6, 4, 7, 2, 3]

        #expect(array == [1, 5, 6, 4, 7, 2, 3])
    }

    @Test("Shuffle ")
    func shuffleArrayWithRandoms() {
        var generator = MT19937RandomGenegator(seed: 1234)
        var array = [
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

        let configuration = FaroShuffleConfiguration(count: 7, middleShiftRange: -10 ... 10, stuckCardsRange: 1 ... 6)

        array.shuffle(algorithm: .faro(configuration), using: &generator)

        let expected = [
            6, 28, 41, 88, 76, 77, 51, 46, 78, 86, 74,
            84, 20, 26, 29, 30, 85, 37, 40, 79, 87, 27,
            36, 24, 50, 56, 57, 93, 75, 21, 22, 52, 5,
            98, 99, 100, 89, 42, 31, 62, 15, 16, 1, 38,
            39, 53, 7, 63, 47, 2, 94, 69, 66, 80, 17, 67,
            95, 8, 96, 25, 81, 9, 58, 97, 90, 68, 3, 82,
            23, 59, 91, 48, 32, 19, 4, 33, 34, 49, 43,
            70, 60, 61, 35, 64, 65, 44, 45, 10, 71, 72,
            73, 18, 83, 11, 12, 13, 14, 92, 54, 55,
        ]

        #expect(array == expected)
    }
}
