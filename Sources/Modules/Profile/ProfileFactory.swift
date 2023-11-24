//
//  ProfileFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class ProfileFactory {
    static func createProfileViewController() -> ProfileViewController {
        let coordinator = ProfileCoordinator()
        let viewModel = ProfileViewModel(coordinator: coordinator)
        let viewController = ProfileViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
