//
//  LoadingState.swift
//  swiftui-uikit
//
//  Created by Michael Schinis on 23/06/2022.
//

import Foundation

/// Convenience enum for loading states with no value
typealias LoadingStateWithoutValue = LoadingState<UUID>

/// A convenience enum that will contain all necessary states to handle API calls
enum LoadingState<Value> {
    /// The API call has not been executed
    case idle

    /// The API call is in flight
    case loading

    /// The API call has failed.
    /// Parameters:
    /// - Error: The resulting error
    case failed(Error)

    /// The API call has finished successfully
    /// Parameters:
    /// - Value: The deserialised object
    case loaded(Value)

    var value: Value? {
        switch self {
        case let .loaded(val): return val
        default: return nil
        }
    }

    var isIdle: Bool {
        switch self {
        case .idle: return true
        default: return false
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }

    var isLoaded: Bool {
        switch self {
        case .loaded: return true
        default: return false
        }
    }
}

extension LoadingState: Equatable where Value: Equatable {
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loading, .loading):
            return true
        case (.loaded(let lhsVal), .loaded(let rhsVal)):
            return lhsVal == rhsVal
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
