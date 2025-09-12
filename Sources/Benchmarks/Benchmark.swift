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

    func benchmark(name _: String, task _: @escaping (BenchmarkContext) -> Void) {}

    func prepare() {}

    mutating func run() throws {
        runRandomGeneratorBenchmark()

        runShuffleBenchmark()

        runRandomUtilsBenchmark()
    }
}

private extension Benchmark {
    func runRandomGeneratorBenchmark() {
        let benchmark = BenchmarkExecuter()

        benchmark.benchmark(name: String(describing: SHA512RandomGenegator.self)) { context in
            var generator = SHA512RandomGenegator(seed: 0)
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

        if #available(macOS 26.0, *) {
            benchmark.benchmark(name: String(describing: InlineMT19937RandomGenegator.self)) { context in
                var generator = InlineMT19937RandomGenegator()
                for _ in 0 ..< 10_000_000 {
                    _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
                }

                context.blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
            }
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

private extension Benchmark {
    func runShuffleBenchmark() {
        let benchmark = BenchmarkExecuter()

        benchmark.benchmark(name: "Array MT19937 (10)") { context in
            var generator = MT19937RandomGenegator()

            var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

            for _ in 0 ..< 10_000_000 {
                array.shuffle(algorithm: .default, using: &generator)
            }

            context.blackHole(array[0])
        }

        benchmark.benchmark(name: "Faro (10)") { context in
            var generator = MT19937RandomGenegator()

            var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

            for _ in 0 ..< 10_000_000 {
                array.shuffle(algorithm: .faro, using: &generator)
            }

            context.blackHole(array[0])
        }

        benchmark.benchmark(name: "Array MT19937 (100)") { context in
            var generator = MT19937RandomGenegator()

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

            for _ in 0 ..< 10_000_000 {
                array.shuffle(algorithm: .default, using: &generator)
            }

            context.blackHole(array[0])
        }

        benchmark.benchmark(name: "Faro MT19937 (100)") { context in
            var generator = MT19937RandomGenegator()

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

            for _ in 0 ..< 10_000_000 {
                array.shuffle(algorithm: .faro, using: &generator)
            }

            context.blackHole(array[0])
        }

        if #available(macOS 26.0, *) {
            benchmark.benchmark(name: "InlineArray InlineMT19937 (10)") { context in
                var generator = InlineMT19937RandomGenegator()

                var array: InlineArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

                for _ in 0 ..< 10_000_000 {
                    array.shuffle(algorithm: .default, using: &generator)
                }

                context.blackHole(array[0])
            }

            benchmark.benchmark(name: "InlineArray InlineMT19937 (100)") { context in
                var generator = InlineMT19937RandomGenegator()

                var array: InlineArray = [
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

                for _ in 0 ..< 10_000_000 {
                    array.shuffle(algorithm: .default, using: &generator)
                }

                context.blackHole(array[0])
            }
        }

        benchmark.start()
    }
}

private extension Benchmark {
    func runRandomUtilsBenchmark() {
        let benchmark = BenchmarkExecuter()

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
