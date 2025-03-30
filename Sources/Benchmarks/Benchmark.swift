//
//  Benchmark.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 30.03.25.
//

import ArgumentParser
import Benchmarks
import struct Foundation.UUID
import Random

@main
struct Benchmark: ParsableCommand {
    mutating func run() throws {
        let benchmark = BenchmarkExecuter()

        benchmark.benchmark(name: "CryptoRandomGenegator") { context in
            var generator = CryptoRandomGenegator(seed: 0)
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        benchmark.benchmark(name: "Random48Genegator") { context in
            var generator = Random48Genegator()
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        benchmark.benchmark(name: "SwiftRandomGenegator") { context in

            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max))
        }

        benchmark.start()
    }
}
