//
//  ContentView.swift
//  swiftui-uikit
//
//  Created by Michael Schinis on 23/06/2022.
//

import Combine
import SwiftUI

struct ContentView: View {
    var publisher: PassthroughSubject<UIKitViewController.Action, Never> = .init()
    
    /// Sends a published event to 
    private func didTapToggleButton() {
        publisher.send(.toggleColor)
    }

    var body: some View {
        VStack {
            UIKitViewControllerRepresentable(text: "Some kind of text", publisher: publisher)

            VStack {
                Spacer()

                HStack(alignment: .bottom) {
                    Button("Toggle background color", action: didTapToggleButton)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
