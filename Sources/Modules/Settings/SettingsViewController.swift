//
//  SettingsViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

class SettingsViewController: BaseHostingController<SettingsView> {
    init(viewModel: SettingsViewModel) {
        super.init(rootView: SettingsView(viewModel: viewModel))
    }
}
