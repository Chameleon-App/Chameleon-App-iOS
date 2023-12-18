//
//  LoginFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

final class LoginFactory {
    static func createLoginViewController() -> LoginViewController {
        let coordinator = LoginCoordinator()
        let viewModel = LoginViewModel(coordinator: coordinator)
        let viewController = LoginViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
