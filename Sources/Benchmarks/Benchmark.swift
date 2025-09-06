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
    @Argument(help: "The phrase to repeat.")
    var `repeat`: Int = 5

    // private let benchmark = BenchmarkExecuter()

    func benchmark(name _: String, task _: @escaping (BenchmarkContext) -> Void) {}

    func prepare() {}

    mutating func run() throws {
        let benchmark = BenchmarkExecuter()

        benchmark.benchmark(name: String(describing: SHA512RandomGenegator.self)) { context in
            var generator = SHA512RandomGenegator(seed: 0)
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        benchmark.benchmark(name: String(describing: Ranlux48RandomGenegator.self)) { context in
            var generator = Ranlux48RandomGenegator()
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        benchmark.benchmark(name: String(describing: MT19937RandomGenegator.self)) { context in
            var generator = MT19937RandomGenegator()
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        #if swift(>=6.2)
            if #available(macOS 26.0, *) {
                benchmark.benchmark(name: String(describing: FastMT19937RandomGenegator.self)) { context in
                    var generator = FastMT19937RandomGenegator()
                    for _ in 0 ..< 10_000_000 {
                        _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
                    }

                    context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
                }
            }

        #endif // swift(>=6.2)

        benchmark.benchmark(name: "SwiftRandomGenegator") { context in
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max)
            }

            context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max))
        }

        benchmark.benchmark(name: "BitRandomGenerator (SHA512)") { context in
            var generator = BitRandomGenerator(SHA512RandomGenegator())

            for _ in 0 ..< 10_000_000 {
                _ = generator.next()
            }

            context.blackHole(generator.next())
        }

        benchmark.benchmark(name: "BitRandomGenerator (MT19937)") { context in
            var generator = BitRandomGenerator(MT19937RandomGenegator())

            for _ in 0 ..< 10_000_000 {
                _ = generator.next()
            }

            context.blackHole(generator.next())
        }

        benchmark.benchmark(name: "Swift Bool (MT19937) ") { context in
            var generator = MT19937RandomGenegator()

            for _ in 0 ..< 10_000_000 {
                _ = Bool.random(using: &generator)
            }

            context.blackHole(Bool.random(using: &generator))
        }

        benchmark.benchmark(name: "Swift Bool Genegator") { context in
            for _ in 0 ..< 10_000_000 {
                _ = Bool.random()
            }

            context.blackHole(Bool.random())
        }

        benchmark.benchmark(name: "ByteRandomGenerator (MT19937)") { context in
            var generator = ByteRandomGenerator(MT19937RandomGenegator())

            for _ in 0 ..< 10_000_000 {
                _ = generator.next()
            }

            context.blackHole(generator.next())
        }

        benchmark.benchmark(name: "Swift Byte (MT19937) ") { context in
            var generator = MT19937RandomGenegator()

            for _ in 0 ..< 10_000_000 {
                _ = UInt8.random(in: .min ... .max, using: &generator)
            }

            context.blackHole(UInt8.random(in: .min ... .max, using: &generator))
        }

        benchmark.benchmark(name: "Swift Byte Genegator") { context in
            for _ in 0 ..< 10_000_000 {
                _ = UInt8.random(in: .min ... .max)
            }

            context.blackHole(UInt8.random(in: .min ... .max))
        }

        benchmark.start()
    }
}
