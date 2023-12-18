//
//  SettingsViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

final class SettingsViewController: BaseHostingController<SettingsView> {
    private enum Constants {
        static let navigationBarTitleKey = "settingsNavigationBarTitle"
    }
    
    init(viewModel: SettingsViewModel) {
        super.init(rootView: SettingsView(viewModel: viewModel))
        
        let navigationBarTitle = String(localized: String.LocalizationValue(Constants.navigationBarTitleKey))
        
        navigationBarModel = NavigationBarModel(
            centralItemModel: NavigationBarCentralItemModel(type: .title(navigationBarTitle)),
            isLargeTitle: true
        )
    }
}
