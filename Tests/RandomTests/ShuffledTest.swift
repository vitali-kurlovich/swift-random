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
    let array: [Int] = []
    // #expect(shuffle(array) == array)
}

@Test("Shuffle One")
func shuffleOne() {
    let array = CollectionOfOne(12)
    // #expect(shuffle(array) == [12])
}
