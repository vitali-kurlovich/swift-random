//
//  ExpandedView.swift
//  SwiftRandom
//
//  Created by Vitali Kurlovich on 8.12.25.
//

import SwiftUI

// struct GradientControlStyle: ButtonStyle {

struct ExpandedViewButtonStyle<Header: View, DisclosureIndicator: View, Content: View>: ButtonStyle {
    let header: Header
    let disclosureIndicator: DisclosureIndicator
    let content: Content

    @Environment(\.isExpanded)
    private var isExpanded: Bool

//    init(@ViewBuilder header: () -> Header,
//         @ViewBuilder disclosureIndicator: () -> DisclosureIndicator,
//         @ViewBuilder content: () -> Content)
//    {
//        self.header = header()
//        self.disclosureIndicator = disclosureIndicator()
//        self.content = content()
//    }

    func makeBody(configuration _: Configuration) -> some View {
        VStack {
            HStack {
                header
                disclosureIndicator
            }
            if isExpanded {
                content
            }
        }
    }
}

struct ExpandedView<Header: View, DisclosureIndicator: View, Content: View>: View {
    let header: Header
    let disclosureIndicator: DisclosureIndicator
    let content: Content

    let p: CGPoint = .zero
    // @Environment(\.isExpanded)
    // private var isExpanded: Bool

    @State
    private var isExpanded: Bool = false

    init(@ViewBuilder header: () -> Header,
         @ViewBuilder disclosureIndicator: () -> DisclosureIndicator,
         @ViewBuilder content: () -> Content)
    {
        self.header = header()
        self.disclosureIndicator = disclosureIndicator()
        self.content = content()
    }

    var body: some View {
        Button("") {
            withAnimation {
                isExpanded.toggle()
            }
        }.buttonStyle(
            ExpandedViewButtonStyle(
                header: header,
                disclosureIndicator: disclosureIndicator,
                content: content
            )
        ).environment(\.isExpanded, isExpanded)
    }
}

#Preview {
    ExpandedView(header: {
        Text("Header")
    }, disclosureIndicator: {
        Color.clear
            .background(.ultraThinMaterial)
            .overlay {
                Image(systemName: "chevron.forward")
            }.clipShape(Circle())
            .frame(width: 28, height: 28)

    }, content: {
        Text("Row 1")
        Text("Row 2")
        Text("Row 3")
    }).environment(\.isExpanded, true)
}
