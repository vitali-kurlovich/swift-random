//
//  Benchmark+RandomGenerator.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 6.03.26.
//

import Benchmarks
import Random

extension Benchmark {
    func runRandomGeneratorBenchmark() {
        let benchmark = BenchmarkExecuter(repeatCount: self.repeat)

        let count = 10_000_000
        let sha512Benshmark = RandomGeneratorBenchmark(count: count, SHA512RandomGenegator(seed: 0))

        benchmark(name: sha512Benshmark.name) {
            sha512Benshmark.run()
        }

        let mt19937Benshmark = RandomGeneratorBenchmark(count: count, MT19937RandomGenegator())

        benchmark(name: mt19937Benshmark.name) {
            mt19937Benshmark.run()
        }

        if #available(macOS 26.0, *) {
            let inlineMT19937Benshmark = RandomGeneratorBenchmark(count: count, InlineMT19937RandomGenegator())
            benchmark(name: inlineMT19937Benshmark.name) {
                mt19937Benshmark.run()
            }
        }

        benchmark(name: "SwiftRandomGenegator") {
            for _ in 0 ..< count {
                _ = UInt64.random(in: UInt64.min ... UInt64.max)
            }

            blackHole(UInt64.random(in: UInt64.min ... UInt64.max))
        }

        benchmark.start()
    }
}
