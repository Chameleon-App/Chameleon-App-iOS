//
//  SettingsView.swift
//  chameleon
//
//  Created by Ilia Chub on 25.11.2023.
//

import SwiftUI

struct SettingsView: View {
    private enum Constants {
        static let changeLanguageTitleKey = "changeLanguageButtonTitle"
        static let logOutButtonTitleKey = "logOutButtonTitle"
    }
    
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(spacing: 28) {
            ButtonView(
                styleType: .primary,
                content: String(localized: String.LocalizationValue(Constants.changeLanguageTitleKey)),
                action: viewModel.handleChangeLanguageButtonDidTap
            )
            ButtonView(
                styleType: .attention,
                content: String(localized: String.LocalizationValue(Constants.logOutButtonTitleKey)),
                action: viewModel.handleLogOutButtonDidTap
            )
        }
        .padding(.horizontal, 64)
    }
}
