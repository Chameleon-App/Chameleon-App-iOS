//
//  LaunchFactory.swift
//  polkadot-mobile
//
//  Created by Ilia Chub on 23.01.2023.
//

import UIKit

enum LaunchFactory {
    static func createLaunchViewController() -> LaunchViewController {
        let coordinator = LaunchCoordinator()
        let viewModel = LaunchViewModel(coordinator: coordinator)
        let viewController = LaunchViewController(viewModel: viewModel)
        
        coordinator.router = viewController
        
        return viewController
    }
}
