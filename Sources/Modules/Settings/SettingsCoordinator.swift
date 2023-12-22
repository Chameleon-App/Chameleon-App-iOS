//
//  SettingsCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

final class SettingsCoordinator {
    weak var router: (NavigationRouter & RootRouter)?
    
    func openLoginScreen() {
        let viewController = LoginFactory.createLoginViewController()
        
        router?.updateRootViewController(viewController: viewController)
    }
}
