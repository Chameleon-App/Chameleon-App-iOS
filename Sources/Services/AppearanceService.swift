//
//  AppearanceService.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

final class AppearanceService {
    static func setup() {
        setupViewAppearance()
        setupTabBarAppearance()
        setupTextViewAppearance()
        setupNavigationBarAppearance()
    }
    
    private static func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(resource: .backgroundBar)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = UIColor(resource: .iconSecondary)
        UITabBar.appearance().tintColor = UIColor(resource: .iconPrimary)
    }
    
    private static func setupViewAppearance() {
        let viewTintColor = UIColor(resource: .textPrimary)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = viewTintColor
    }
    
    private static func setupTextViewAppearance() {
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().textContainerInset = .init(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private static func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithDefaultBackground()
        
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = UIColor(resource: .backgroundCommon)
        
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor(resource: .textPrimary)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
    }
}
