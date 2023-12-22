//
//  BaseNavigationController.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import UIKit

final class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > .one
    }
}
