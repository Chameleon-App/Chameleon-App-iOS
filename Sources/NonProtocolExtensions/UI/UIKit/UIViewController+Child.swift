//
//  UIViewController+Child.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

extension UIViewController {
    private enum Constants {
        static let fadeAnimationDuration = 0.5
    }
    
    func addChild(controller: UIViewController) {
        view.layoutSubview(controller.view, safe: false)
        addChild(controller)
        
        controller.view.alpha = .zero

        UIView.animate(withDuration: Constants.fadeAnimationDuration) {
            controller.view.alpha = .one

            if self.children.count > .one {
                self.removeChild(controller: self.children.first)
            }
        }
    }

    private func removeChild(controller: UIViewController?) {
        guard controller?.parent != nil else {
            return
        }

        controller?.willMove(toParent: nil)
        controller?.removeFromParent()
        controller?.view.removeFromSuperview()
    }
}
