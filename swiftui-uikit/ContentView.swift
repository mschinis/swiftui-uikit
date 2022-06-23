//
//  ContentView.swift
//  swiftui-uikit
//
//  Created by Michael Schinis on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    private func didTapToggleButton() {
        
    }
    
    var body: some View {
        VStack {
            UIKitViewControllerRepresentable(text: "Some kind of text")

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
