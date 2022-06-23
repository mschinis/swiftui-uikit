//
//  UIKitView.swift
//  swiftui-uikit
//
//  Created by Michael Schinis on 23/06/2022.
//

import Foundation
import UIKit
import SwiftUI

class UIKitViewController: UIViewController {
    // This UIViewController has parameters passed in from the caller
    let text: String

    lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = text
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Should not be used")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    /// Toggle the color of the label, called by the parent view (SwiftUI)
    func toggleColor() {
        if labelView.backgroundColor == .black {
            labelView.backgroundColor = .white
            labelView.textColor = .black
        } else {
            labelView.backgroundColor = .black
            labelView.textColor = .white
        }
    }
}

struct UIKitViewControllerRepresentable: UIViewControllerRepresentable {
    let text: String

    func makeUIViewController(context: Context) -> UIKitViewController {
        UIKitViewController(text: text)
    }
    
    func updateUIViewController(_ uiViewController: UIKitViewController, context: Context) {
        
    }
}
