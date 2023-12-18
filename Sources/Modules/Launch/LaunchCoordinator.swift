//
//  LaunchCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 23.01.2023.
//

final class LaunchCoordinator {
    var router: RootRouter?

    func openMainScreen() {
        let tabBarController = RootTabBarFactory.createRootTabBarController()

        router?.updateRootViewController(viewController: tabBarController)
    }
    
    func openLoginScreen() {
        
    }
}
