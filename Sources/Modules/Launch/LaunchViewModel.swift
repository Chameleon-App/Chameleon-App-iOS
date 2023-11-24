//
//  LaunchViewModel.swift
//  polkadot-mobile
//
//  Created by Ilia Chub on 23.01.2023.
//

import SwiftUI

final class LaunchViewModel: ObservableObject {
    private var coordinator: LaunchCoordinator
    
    init(coordinator: LaunchCoordinator) {
        self.coordinator = coordinator
    }
    
    func openMainScreen() {
        coordinator.openMainScreen()
    }
}
