//
//  ContentView.swift
//  RandomApp
//
//  Created by Vitali Kurlovich on 5.11.25.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: RandomAppDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(RandomAppDocument()))
}
