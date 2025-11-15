//
//  CadrsDeckModel.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 5.10.25.
//

import struct Foundation.UUID
import Observation
import Random

@Observable
final class CadrsDeckModel {
    var algorithm = ShuffleAlgorithm.default
}
