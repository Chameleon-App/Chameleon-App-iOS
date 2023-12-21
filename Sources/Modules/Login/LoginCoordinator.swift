//
//  LoginCoordinator.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

final class LoginCoordinator {
    weak var router: (NavigationRouter & RootRouter)?
    
    func openMainScreen() {
        let tabBarController = RootTabBarFactory.createRootTabBarController()

        router?.updateRootViewController(viewController: tabBarController)
    }
    
    func openSignupScreen() {
        let viewController = SignupFactory.createSignupViewController()
        
        router?.updateRootViewController(viewController: viewController)
    }
}
