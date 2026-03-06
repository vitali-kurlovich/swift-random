//
//  Created by Vitali Kurlovich on 6.03.26.
//

import Benchmarks
import Random

extension Benchmark {
    func runRandomUtilsBenchmark() {
        let benchmark = BenchmarkExecuter(repeatCount: self.repeat)

        let count = 10_000_000

        benchmark(name: "BitRandomGenerator (SHA512)") {
            var generator = BitRandomGenerator(SHA512RandomGenegator())

            for _ in 0 ..< count {
                _ = generator.next()
            }

            blackHole(generator.next())
        }

        benchmark(name: "BitRandomGenerator (MT19937)") {
            var generator = BitRandomGenerator(MT19937RandomGenegator())

            for _ in 0 ..< count {
                _ = generator.next()
            }

            blackHole(generator.next())
        }

        benchmark(name: "Swift Bool (MT19937) ") {
            var generator = MT19937RandomGenegator()

            for _ in 0 ..< count {
                _ = Bool.random(using: &generator)
            }

            blackHole(Bool.random(using: &generator))
        }

        benchmark(name: "Swift Bool Genegator") {
            for _ in 0 ..< count {
                _ = Bool.random()
            }

            blackHole(Bool.random())
        }

        benchmark(name: "ByteRandomGenerator (MT19937)") {
            var generator = ByteRandomGenerator(MT19937RandomGenegator())

            for _ in 0 ..< count {
                _ = generator.next()
            }

            blackHole(generator.next())
        }

        benchmark(name: "Swift Byte (MT19937) ") {
            var generator = MT19937RandomGenegator()

            for _ in 0 ..< count {
                _ = UInt8.random(in: .min ... .max, using: &generator)
            }

            blackHole(UInt8.random(in: .min ... .max, using: &generator))
        }

        benchmark(name: "Swift Byte Genegator") {
            for _ in 0 ..< count {
                _ = UInt8.random(in: .min ... .max)
            }

            blackHole(UInt8.random(in: .min ... .max))
        }

        benchmark.start()
    }
}
