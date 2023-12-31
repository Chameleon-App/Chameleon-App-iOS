//
//  ProfileCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class ProfileCoordinator {
    weak var router: (NavigationRouter & RootRouter)?

    func openLoginScreen() {
        let viewController = LoginFactory.createLoginViewController()

        router?.updateRootViewController(viewController: viewController)
    }
}
