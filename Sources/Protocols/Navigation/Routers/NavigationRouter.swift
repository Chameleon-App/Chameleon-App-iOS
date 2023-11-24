//
//  NavigationRouter.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

protocol NavigationRouter: AnyObject {
    func push(controller: UIViewController, animated: Bool)
    func popToRoot(isAnimated: Bool)
    func pop()
}

extension UIViewController: NavigationRouter {
    func push(controller: UIViewController, animated: Bool) {
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func popToRoot(isAnimated: Bool = true) {
        navigationController?.popToRootViewController(animated: isAnimated)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
