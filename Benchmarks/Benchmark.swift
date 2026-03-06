//
//  Created by Vitali Kurlovich on 30.03.25.
//

import ArgumentParser
import Benchmarks

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
