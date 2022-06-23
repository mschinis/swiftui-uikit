//
//  UIKitView.swift
//  swiftui-uikit
//
//  Created by Michael Schinis on 23/06/2022.
//

import Combine
import Foundation
import UIKit
import SwiftUI

class UIKitViewController: UIViewController {
    enum Action {
        case toggleColor
    }

    // This UIViewController has parameters passed in from the caller
    let text: String

    private var publisher: PassthroughSubject<Action, Never>
    private var subscriptions: Set<AnyCancellable> = .init()
    
    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = text
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    init(text: String, publisher: PassthroughSubject<Action, Never>) {
        self.text = text
        self.publisher = publisher
        
        super.init(nibName: nil, bundle: nil)

        // Listen for updates coming from SwiftUI
        publisher
            .receive(on: DispatchQueue.main)
            .sink { action in
                switch action {
                case .toggleColor: self.toggleColor()
                }
            }
            .store(in: &subscriptions)
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
    private func toggleColor() {
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
    let publisher: PassthroughSubject<UIKitViewController.Action, Never>

    func makeUIViewController(context: Context) -> UIKitViewController {
        UIKitViewController(text: text, publisher: publisher)
    }
    
    func updateUIViewController(_ uiViewController: UIKitViewController, context: Context) {
        
    }
}
