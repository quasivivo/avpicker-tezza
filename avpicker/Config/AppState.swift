//
//  AppState.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftUI

protocol AppStateProtocol {
    var state: ImporterWorkflowState { get set }
    func transition(to newState: ImporterWorkflowState)
}

final class AppState: ObservableObject, AppStateProtocol {
    // TODO: Presumably ImporterWorkflow would be a sibling state of additional flows. Keeping it simple to start.
    @Published var state: ImporterWorkflowState = .idle

    func transition(to newState: ImporterWorkflowState) {
        state = newState
    }
}
