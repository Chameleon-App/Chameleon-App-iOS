//
//  SignupFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

final class SignupFactory {
    static func createSignupViewController() -> SignupViewController {
        let coordinator = SignupCoordinator()
        let viewModel = SignupViewModel(coordinator: coordinator)
        let viewController = SignupViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
