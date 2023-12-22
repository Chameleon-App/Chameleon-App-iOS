//
//  SignupCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

final class SignupCoordinator {
    weak var router: (NavigationRouter & RootRouter)?
    
    func openMainScreen() {
        let tabBarController = RootTabBarFactory.createRootTabBarController()

        router?.updateRootViewController(viewController: tabBarController)
    }
    
    func openLoginScreen() {
        let viewController = LoginFactory.createLoginViewController()
        
        router?.updateRootViewController(viewController: viewController)
    }
}
