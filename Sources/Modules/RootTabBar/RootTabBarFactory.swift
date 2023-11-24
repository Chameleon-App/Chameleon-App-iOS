//
//  RootTabBarFactory.swift
//  chameleon
//
//  Created by Ilia Chub on 23.01.2023.
//

import UIKit
 
final class RootTabBarFactory {
    private enum Constants {
        static let calendarTabTitleKey = "calendarTabTitle"
        static let searchTabTitleKey = "searchTabTitle"
        static let profileTabTitleKey = "profileTabTitle"
        static let settingsTabTitleKey = "settingsTabTitle"
    }
    
    static func createRootTabBarController() -> RootTabBarController {
        let controller = RootTabBarController()
        
        let calendarViewController = CalendarFactory.createCalendarViewController()
        let calendarNavigationController = BaseNavigationController(rootViewController: calendarViewController)
        
        let searchViewController = SearchFactory.createSearchViewController()
        let searchNavigationController = BaseNavigationController(rootViewController: searchViewController)
        
        let profileViewController = ProfileFactory.createProfileViewController()
        let profileNavigationController = BaseNavigationController(rootViewController: profileViewController)
        
        let settingsViewController = SettingsFactory.createSettingsViewController()
        let settingsNavigationController = BaseNavigationController(rootViewController: settingsViewController)
        
        controller.viewControllers = [
            calendarNavigationController,
            searchNavigationController,
            profileNavigationController,
            settingsNavigationController
        ]
        
        configureTabBarAppearance(
            calendarNavigationController: calendarNavigationController,
            searchNavigationController: searchNavigationController, 
            profileNavigationController: profileNavigationController,
            settingsNavigationController: settingsNavigationController,
            tabBarController: controller
        )
        
        return controller
    }
    
    private static func configureTabBarAppearance(
        calendarNavigationController: BaseNavigationController,
        searchNavigationController: BaseNavigationController,
        profileNavigationController: BaseNavigationController,
        settingsNavigationController: BaseNavigationController,
        tabBarController: RootTabBarController
    ) {
        calendarNavigationController.tabBarItem = UITabBarItem(
            title: String(localized: .init(Constants.calendarTabTitleKey)),
            image: UIImage(resource: .ic18Calendar),
            selectedImage: nil
        )
        
        searchNavigationController.tabBarItem = UITabBarItem(
            title: String(localized: .init(Constants.searchTabTitleKey)),
            image: UIImage(resource: .ic18Search),
            selectedImage: nil
        )
        
        profileNavigationController.tabBarItem = UITabBarItem(
            title: String(localized: .init(Constants.profileTabTitleKey)),
            image: UIImage(resource: .ic18Profile),
            selectedImage: nil
        )
        
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: String(localized: .init(Constants.settingsTabTitleKey)),
            image: UIImage(resource: .ic18Settings),
            selectedImage: nil
        )
        
        tabBarController.tabBar.shadowImage = nil
        tabBarController.tabBar.clipsToBounds = true
    }
}
