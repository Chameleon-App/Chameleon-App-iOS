//
//  RootViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

class RootViewModel {
    private var coordinator: RootCoordinator

    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
    }
    
    func openLaunchScreen() {
        coordinator.openLaunchScreen()
    }
}
