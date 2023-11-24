//
//  SettingsViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    private var coordinator: SettingsCoordinator

    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
}
