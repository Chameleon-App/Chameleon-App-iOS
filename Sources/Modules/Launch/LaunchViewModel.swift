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
        if getIsUserAuthenticated() {
            openMainScreen()
        } else {
            openLoginScreen()
        }
    }
    
    private func openMainScreen() {
        coordinator.openMainScreen()
    }
    
    private func openLoginScreen() {
        coordinator.openLoginScreen()
    }
    
    private func getIsUserAuthenticated() -> Bool {
        return authenticationRepository.getAuthenticationKey()
    }
}
