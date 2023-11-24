//
//  PresentationRouter.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

protocol PresentationRouter: AnyObject {
    func present(controller: UIViewController, completion: Closure.Void?)
    func dismiss()
}

extension UIViewController: PresentationRouter {
    func present(controller: UIViewController, completion: Closure.Void? = nil) {
        present(controller, animated: true, completion: completion)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
