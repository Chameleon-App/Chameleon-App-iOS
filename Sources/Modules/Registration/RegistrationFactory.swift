//
//  RegistrationFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

final class RegistrationFactory {
    static func createRegistrationViewController() -> RegistrationViewController {
        let coordinator = RegistrationCoordinator()
        let viewModel = RegistrationViewModel(coordinator: coordinator)
        let viewController = RegistrationViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
