//
//  Array+Shuffled.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 27.07.25.
//

public extension Array {
    func shuffled<T>(using generator: inout T) -> Self where T: RandomNumberGenerator {
        var array = self
        var result: [Self.Element] = []
        while !array.isEmpty, let index = array.indices.randomElement(using: &generator) {
            let element = array.remove(at: index)
            result.append(element)
        }

        return result
    }

    func shuffled() -> Self {
        var generator = MT19937RandomGenegator()
        return shuffled(using: &generator)
    }
}
