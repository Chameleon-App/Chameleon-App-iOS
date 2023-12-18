//
//  SettingsViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    private var coordinator: SettingsCoordinator

    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleChangeLanguageButtonDidTap() {
        DeeplinkService.openAppSettings()
    }
    
    func handleLogOutButtonDidTap() {
        print(#function)
    }
}
