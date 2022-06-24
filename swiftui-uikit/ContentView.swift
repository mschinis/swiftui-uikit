//
//  ContentView.swift
//  swiftui-uikit
//
//  Created by Michael Schinis on 23/06/2022.
//

import Combine
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    var publisher: PassthroughSubject<UIKitViewController.Action, Never> = .init()
    var updatesPublisher: PassthroughSubject<UIKitViewController.Update, Never> = .init()
    
    private var subscriptions: Set<AnyCancellable> = .init()

    @Published var toggleColorLoadingState: LoadingStateWithoutValue = .idle

    init() {
        updatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { update in
                switch update {
                case let .toggleColor(loadingState):
                    self.toggleColorLoadingState = loadingState
                }
            }
            .store(in: &subscriptions)
    }

    /// Sends a published event to uikit
    func didTapToggleButton() {
        publisher.send(.toggleColor)
    }
}

struct ContentView: View {
    var publisher: PassthroughSubject<UIKitViewController.Action, Never> = .init()
    var updatesPublisher: PassthroughSubject<UIKitViewController.Update, Never> = .init()
    
    @StateObject private var viewModel = ContentViewModel()
    

    var body: some View {
        VStack {
            UIKitViewControllerRepresentable(
                text: "Some kind of text",
                publisher: viewModel.publisher,
                updatesPublisher: viewModel.updatesPublisher
            )

            VStack {
                Spacer()

                HStack(alignment: .bottom) {
                    Button("Toggle background color", action: {
                        viewModel.didTapToggleButton()
                    })
                    .disabled(viewModel.toggleColorLoadingState.isLoading)
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
