//
//  CadrsViewController.swift
//  RandomPlayground
//
//  Created by Vitali Kurlovich on 25.09.25.
//

import Observation
import Random
import SwiftUI
import UIKit

class ShuffleSettingsViewController {}

struct ShuffleSettingsView: View {
    let model: CadrsDeckModel

    var body: some View {
        EmptyView()
    }
}

class CadrsViewController: UIViewController {
    private let viewModel = CadrsDeckModel()

    @IBOutlet
    var interactionLabel: InteractionLabel? {
        didSet {
            // interactionLabel?.addInteraction(findInteraction)
        }
    }

    @IBOutlet
    var textView: UITextView? {
        didSet {
            textView?.isFindInteractionEnabled = true

            guard let textView else {
                return
            }

            let interaction = UIFindInteraction(sessionDelegate: textView)
            textView.addInteraction(interaction)
        }
    }

    override var canBecomeFirstResponder: Bool {
        true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let deck = CardsDeck()
        print(deck)

        //  view.addInteraction(findInteraction)

        // Do any additional setup after loading the view.
    }

    @IBAction
    func presentSearch() {
        //  findInteraction.presentFindNavigator(showingReplace: true)
    }

    override func updateProperties() {
        // let pasteboard = UIPasteboard.general

        // pasteboard.value(forPasteboardType: .uuid)
    }
}

struct CardView: View {
    let card: Card

    var body: some View {
        switch card.suit {
        default:
            EmptyView()
        }
    }
}
