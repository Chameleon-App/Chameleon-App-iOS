//
//  LaunchViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 23.01.2023.
//

import SwiftUI

final class LaunchViewModel: ObservableObject {
    private var coordinator: LaunchCoordinator
    private let authenticationRepository: AuthenticationRepository
    
    init(coordinator: LaunchCoordinator) {
        self.coordinator = coordinator
        self.authenticationRepository = AuthenticationRepository()
    }
    
    func handleViewDidAppear() {
        Task {
            if await getIsUserAuthenticated() {
                openMainScreen()
            } else {
                openLoginScreen()
            }
        }
    }
    
    private func openMainScreen() {
        Task { @MainActor in coordinator.openMainScreen() }
    }
    
    private func openLoginScreen() {
        Task { @MainActor in coordinator.openLoginScreen() }
    }
    
    private func getIsUserAuthenticated() async -> Bool {
        return await authenticationRepository.getIsUserAuthenticated()
    }
}
