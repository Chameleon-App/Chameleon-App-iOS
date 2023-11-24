//
//  RootCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class RootCoordinator {
    weak var router: RootRouter?

    func openLaunchScreen() {
        let viewController = LaunchFactory.createLaunchViewController()

        router?.updateRootViewController(viewController: viewController)
    }
}
