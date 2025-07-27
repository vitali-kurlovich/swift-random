//
//  shuffle.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

public func shuffle<T, S: Sequence>(_ collection: S, using generator: inout T) -> [S.Element] where T: RandomNumberGenerator {
    var array = Array(collection)
    var result: [S.Element] = []
    while !array.isEmpty, let index = array.indices.randomElement(using: &generator) {
        let element = array.remove(at: index)
        result.append(element)
    }

    return result
}

public func shuffle<S: Sequence>(_ collection: S) -> [S.Element] {
    var generator = MT19937RandomGenegator()
    return shuffle(collection, using: &generator)
}
