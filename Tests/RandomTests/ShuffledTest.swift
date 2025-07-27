//
//  ShuffledTest.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

import Testing

@Test("Shuffle empty")
func shuffledEmpty() {
    let array: [Int] = []
    #expect( array.shuffled() ==  array)
}
