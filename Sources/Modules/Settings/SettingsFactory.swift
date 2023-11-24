//
//  SettingsFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class SettingsFactory {
    static func createSettingsViewController() -> SettingsViewController {
        let coordinator = SettingsCoordinator()
        let viewModel = SettingsViewModel(coordinator: coordinator)
        let viewController = SettingsViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
