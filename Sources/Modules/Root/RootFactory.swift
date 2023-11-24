//
//  RootFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

enum RootFactory {
    static func createRootViewController() -> RootViewController {
        let coordinator = RootCoordinator()
        let viewModel = RootViewModel(coordinator: coordinator)
        let viewController = RootViewController(viewModel: viewModel)

        coordinator.router = viewController
        
        return viewController
    }
}
