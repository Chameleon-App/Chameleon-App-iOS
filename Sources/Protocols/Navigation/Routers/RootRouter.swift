//
//  RootRouter.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

protocol RootRouter: AnyObject {
    func updateRootViewController(viewController: UIViewController)
}

extension UIViewController: RootRouter {
    var fullscreenChild: UIViewController? { children.first }
    
    func updateRootViewController(viewController: UIViewController) {
        let rootViewController = UIApplication.shared.mainWindow?.rootViewController as? RootViewController

        rootViewController?.presentedViewController?.dismiss()
        rootViewController?.addChild(controller: viewController)
    }
}
