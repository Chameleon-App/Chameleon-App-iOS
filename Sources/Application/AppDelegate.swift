//
//  AppDelegate.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

@_exported import Utils

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        AppearanceService.setup()
        
        return true
    }
}
