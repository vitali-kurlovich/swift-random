//
//  RandomAppApp.swift
//  RandomApp
//
//  Created by Vitali Kurlovich on 5.11.25.
//

import SwiftUI

@main
struct RandomAppApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: RandomAppDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
