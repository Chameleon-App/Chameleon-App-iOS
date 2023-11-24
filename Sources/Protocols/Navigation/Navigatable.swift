//
//  Navigatable.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

protocol Navigatable {
    var navigationBarModel: NavigationBarModel { get }
    var isNavigationBarHidden: Bool { get }
    var isBackButtonHidden: Bool { get }
    
    func configureNavigationBar()
}

extension Navigatable where Self: UIViewController {
    func configureNavigationBar() {
        configureNavigationBarCentralItem()
        configureNavigationBarLeftItem()
        configureNavigationBarRightItems()
    }
    
    func configureNavigationBarVisibility() {
        navigationController?.navigationBar.isHidden = isNavigationBarHidden
        navigationItem.setHidesBackButton(isBackButtonHidden, animated: false)
    }
    
    private func configureNavigationBarCentralItem() {
        navigationController?.navigationBar.tintColor = UIColor(resource: .textPrimary)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = navigationBarModel.isLargeTitle ? .always : .never
        configureToolbarItem()
    }
    
    private func configureToolbarItem() {
        if navigationBarModel.isLargeTitle {
            configureLargeTitleIfNeeded()
        } else {
            navigationItem.titleView = NavigationBarCentralItemView(model: navigationBarModel.centralItemModel)
        }
    }
    
    private func configureNavigationBarLeftItem() {
        navigationItem.backButtonDisplayMode = .minimal
        
        switch navigationBarModel.leftItemModel.type {
        case let .icon(icon):
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: icon,
                style: .plain,
                target: self,
                action: #selector(navigationBarLeftItemDidTapped)
            )
        case let .title(title):
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: title,
                style: .plain,
                target: self,
                action: #selector(navigationBarLeftItemDidTapped)
            )
        case let .customView(view):
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                customView: view
            )
        case .empty:
            navigationItem.leftBarButtonItem = .none
            navigationItem.hidesBackButton = true
        }
        
        navigationItem.leftBarButtonItem?.isEnabled = navigationBarModel.leftItemModel.isEnabled
    }
    
    private func configureNavigationBarRightItems() {
        var rightBarButtonItems: [UIBarButtonItem] = []

        for index in navigationBarModel.rightItemsModels.indices {
            let itemModel = navigationBarModel.rightItemsModels[index]
            
            switch itemModel.type {
            case .icon(let icon):
                let newBarButtonItem = UIBarButtonItem(
                    image: icon,
                    style: .plain,
                    target: self,
                    action: #selector(navigationBarRightItemDidTapped)
                )
                newBarButtonItem.isEnabled = itemModel.isEnabled
                newBarButtonItem.tag = index
                rightBarButtonItems.append(newBarButtonItem)
            case let .title(title):
                let newBarButtonItem = UIBarButtonItem(
                    title: title,
                    style: .plain,
                    target: self,
                    action: #selector(navigationBarRightItemDidTapped)
                )
                
                newBarButtonItem.tag = index
                newBarButtonItem.isEnabled = itemModel.isEnabled
                rightBarButtonItems.append(newBarButtonItem)
            case let .customView(view):
                let newBarButtonItem = UIBarButtonItem(customView: view)
                newBarButtonItem.isEnabled = itemModel.isEnabled
                rightBarButtonItems.append(newBarButtonItem)
            case .empty:
                break
            }
        }
                
        navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    private func configureLargeTitleIfNeeded() {
        if case .title(let title) = navigationBarModel.centralItemModel.type {
            navigationItem.title = title
        } else {
            navigationItem.title = .empty
        }
    }
}

fileprivate extension UIViewController {
    @objc func navigationBarLeftItemDidTapped() {
        guard let self = self as? Navigatable else {
            return
        }
        
        switch self.navigationBarModel.leftItemModel.type {
        case .icon, .title, .empty, .customView:
            break
        }
        
        self.navigationBarModel.leftItemModel.onTapAction?()
    }
    
    @objc func navigationBarRightItemDidTapped(_ sender: UITabBarItem) {
        guard let self = self as? Navigatable else {
            return
        }
        
        self.navigationBarModel.rightItemsModels[sender.tag].onTapAction?()
    }
}

