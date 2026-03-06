//
//  Created by Vitali Kurlovich on 6.03.26.
//

import Benchmarks

struct RandomGeneratorBenchmark<R: RandomNumberGenerator>: CustomStringConvertible {
    let count: Int

    let generator: R

    var description: String {
        String(describing: R.self)
    }

    init(count: Int, _ generator: R) {
        self.count = count
        self.generator = generator
    }

    func run() {
        var generator = self.generator

        for _ in 0 ..< count {
            _ = UInt64.random(in: UInt64.min ... UInt64.max, using: &generator)
        }

        blackHole(UInt64.random(in: UInt64.min ... UInt64.max, using: &generator))
    }
}
