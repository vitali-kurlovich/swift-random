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
        var array: [Int] = [1, 2, 3, 4, 5, 6]
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

        var array: [Int] = [1, 2, 3, 4, 5, 6]
        array.shuffle(algorithm: .faro(configuration), using: &generator)

        // [1, 2, 3, 4, 5, 6] : [1, 2, 3] | [4, 5, 6] -> [4, 5, 1, 2, 6, 3]
        // [4, 5, 1, 2, 6, 3] : [4, 5, 1] | [2, 6, 3] -> [4, 5, 2, 6, 1, 3]
        // [4, 5, 2, 6, 1, 3] : [4, 5, 2] | [6, 1, 3] -> [4, 5, 6, 1, 2, 3]
        // [4, 5, 6, 1, 2, 3] : [4, 5, 6] | [1, 2, 3] -> [1, 2, 4, 5, 3, 6]

        #expect(array == [1, 2, 4, 5, 3, 6])
    }
}
