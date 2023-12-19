//
//  SettingsViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    private let coordinator: SettingsCoordinator
    private let authenticationRepository: AuthenticationRepository

    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
        self.authenticationRepository = AuthenticationRepository()
    }
    
    func handleChangeLanguageButtonDidTap() {
        DeeplinkService.openAppSettings()
    }
    
    func handleLogoutButtonDidTap() {
        logout()
    }
    
    private func logout() {
        authenticationRepository.logout()
        openLoginScreen()
    }
    
    private func openLoginScreen() {
        coordinator.openLoginScreen()
    }
}
