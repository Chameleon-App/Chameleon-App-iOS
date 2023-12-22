//
//  UIApplication+Windows.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

extension UIApplication {
    var mainWindow: UIWindow? { mainSceneDelegate?.window }
    
    private var mainScene: UIScene? { UIApplication.shared.connectedScenes.first }
    private var mainSceneDelegate: SceneDelegate? { mainScene?.delegate as? SceneDelegate }
}
