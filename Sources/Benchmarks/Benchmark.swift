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

    mutating func run() throws {
        runRandomGeneratorBenchmark()

        runShuffleBenchmark()

        runRandomUtilsBenchmark()
    }
}

private extension Benchmark {
    func runRandomGeneratorBenchmark() {
        let benchmark = BenchmarkExecuter(repeatCount: self.repeat)

        benchmark(name: String(describing: SHA512RandomGenegator.self)) {
            var generator = SHA512RandomGenegator(seed: 0)
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        benchmark(name: String(describing: MT19937RandomGenegator.self)) {
            var generator = MT19937RandomGenegator()
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
            }

            blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
        }

        if #available(macOS 26.0, *) {
            benchmark(name: String(describing: InlineMT19937RandomGenegator.self)) {
                var generator = InlineMT19937RandomGenegator()
                for _ in 0 ..< 10_000_000 {
                    _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
                }

                blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
            }
        }

        benchmark(name: "SwiftRandomGenegator") {
            for _ in 0 ..< 10_000_000 {
                _ = UInt64.random(in: UInt64.min ... UInt64.max)
            }

            blackHole(UInt64.random(in: UInt64.min ... UInt64.max))
        }

        benchmark.start()
    }
}

private extension Benchmark {
    func runShuffleBenchmark() {
        let benchmark = BenchmarkExecuter(repeatCount: self.repeat)

        benchmark(name: "Array MT19937 (10)") {
            var generator = MT19937RandomGenegator()

            var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

            for _ in 0 ..< 100_000 {
                array.shuffle(algorithm: .default, using: &generator)
            }

            blackHole(array[0])
        }

        benchmark(name: "Array SHA512 (10)") {
            var generator = SHA512RandomGenegator(repeatCount: self.repeat)

            var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

            for _ in 0 ..< 100_000 {
                array.shuffle(algorithm: .default, using: &generator)
            }

            blackHole(array[0])
        }

        if #available(macOS 26.0, *) {
            benchmark(name: "InlineArray InlineMT19937 (10)") {
                var generator = InlineMT19937RandomGenegator()

                var array: InlineArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

                for _ in 0 ..< 100_000 {
                    array.shuffle(algorithm: .default, using: &generator)
                }

                blackHole(array[0])
            }
        }

        benchmark(name: "Faro (10)") {
            var generator = MT19937RandomGenegator()

            var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

            let configuration = FaroShuffleConfiguration(count: 10, middleShiftRange: -3 ... 3, stuckCardsRange: 1 ... 3)

            for _ in 0 ..< 100_000 {
                array.shuffle(algorithm: .faro(configuration), using: &generator)
            }

            blackHole(array[0])
        }

        benchmark(name: "Array MT19937 (100)") {
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

            for _ in 0 ..< 100_000 {
                array.shuffle(algorithm: .default, using: &generator)
            }

            blackHole(array[0])
        }

        if #available(macOS 26.0, *) {
            benchmark(name: "InlineArray InlineMT19937 (100)") {
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

                for _ in 0 ..< 100_000 {
                    array.shuffle(algorithm: .default, using: &generator)
                }

                blackHole(array[0])
            }
        }

        benchmark(name: "Faro MT19937 (100)") {
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

            let configuration = FaroShuffleConfiguration(count: 10, middleShiftRange: -20 ... 20, stuckCardsRange: 1 ... 5)

            for _ in 0 ..< 100_000 {
                array.shuffle(algorithm: .faro(configuration), using: &generator)
            }

            blackHole(array[0])
        }

        if #available(macOS 26.0, *) {
            benchmark(name: "Faro InlineArray MT19937 (100)") {
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

                let configuration = FaroShuffleConfiguration(count: 10) // , middleShiftRange: -20 ... 20, stuckCardsRange: 1 ... 5)

                for _ in 0 ..< 100_000 {
                    array.shuffle(algorithm: .faro(configuration), using: &generator)
                }

                blackHole(array[0])
            }
        }

        benchmark.start()
    }
}

private extension Benchmark {
    func runRandomUtilsBenchmark() {
        let benchmark = BenchmarkExecuter(repeatCount: self.repeat)

        benchmark(name: "BitRandomGenerator (SHA512)") {
            var generator = BitRandomGenerator(SHA512RandomGenegator())

            for _ in 0 ..< 10_000_000 {
                _ = generator.next()
            }

            blackHole(generator.next())
        }

        benchmark(name: "BitRandomGenerator (MT19937)") {
            var generator = BitRandomGenerator(MT19937RandomGenegator())

            for _ in 0 ..< 10_000_000 {
                _ = generator.next()
            }

            blackHole(generator.next())
        }

        benchmark(name: "Swift Bool (MT19937) ") {
            var generator = MT19937RandomGenegator()

            for _ in 0 ..< 10_000_000 {
                _ = Bool.random(using: &generator)
            }

            blackHole(Bool.random(using: &generator))
        }

        benchmark(name: "Swift Bool Genegator") {
            for _ in 0 ..< 10_000_000 {
                _ = Bool.random()
            }

            blackHole(Bool.random())
        }

        benchmark(name: "ByteRandomGenerator (MT19937)") {
            var generator = ByteRandomGenerator(MT19937RandomGenegator())

            for _ in 0 ..< 10_000_000 {
                _ = generator.next()
            }

            blackHole(generator.next())
        }

        benchmark(name: "Swift Byte (MT19937) ") {
            var generator = MT19937RandomGenegator()

            for _ in 0 ..< 10_000_000 {
                _ = UInt8.random(in: .min ... .max, using: &generator)
            }

            blackHole(UInt8.random(in: .min ... .max, using: &generator))
        }

        benchmark(name: "Swift Byte Genegator") {
            for _ in 0 ..< 10_000_000 {
                _ = UInt8.random(in: .min ... .max)
            }

            blackHole(UInt8.random(in: .min ... .max))
        }

        benchmark.start()
    }
}
