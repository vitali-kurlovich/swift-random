//
//  Playground.swift
//  swift-random
//
//  Created by Vitali Kurlovich on 6.11.25.
//

#if DEBUG
#if canImport(SwiftUI)
import SwiftUI


@main
struct RandomAppApp: App {
    var body: some Scene {
        WindowGroup {
            Color.red
        }
    }
}









#Preview() {
    VStack {

        ForEach(0..<52) { index in

            let hue = Double(index) / 52.0
            Rectangle().fill( Color.init(hue: hue, saturation: 1, brightness: 1))

        }

    }
}
#endif // canImport(SwiftUI)
#endif // DEBUG

