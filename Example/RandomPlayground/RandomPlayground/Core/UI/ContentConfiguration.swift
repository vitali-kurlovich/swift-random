//
//  ContentControl+Rep.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 21.10.25.
//

import SwiftUI
import UIKit

struct ContentConfiguration<Configuration: UIContentConfiguration>: UIViewRepresentable {
   
    typealias UIViewType = UIView
    
    @Binding var configuration: Configuration
    
    func makeUIView(context: Context) -> UIViewType {
        configuration.makeContentView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let contentView = uiView as? UIContentView else {
            return
        }
        
        context.animate {
            contentView.configuration = configuration
            uiView.layoutIfNeeded()
        }
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: Self.UIViewType, context: Self.Context) -> CGSize? {
        let size = proposal.replacingUnspecifiedDimensions()
        
        return  uiView.systemLayoutSizeFitting(size)
    }
}


#Preview {
  
    @Previewable @State var configuration = LabelConfiguration(text: "Toogle On", textProperties: .init(textAlignment: .center))
    VStack {
        ContentConfiguration(configuration: $configuration)
            .border(Color.red)
            .padding()
        
        Button("Toogle") {
            withAnimation(.bouncy) {
                if configuration.text == "Toogle On" {
                    configuration.text = "Toogle Offffffff"
                } else {
                    configuration.text = "Toogle On"
                }
            }
        }
    }.border(Color.primary)
    
}
