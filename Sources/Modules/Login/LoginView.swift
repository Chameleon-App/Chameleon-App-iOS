//
//  LoginView.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI

struct LoginView: View {
    private enum Constants {
        static let loginButtonTitleKey = "loginTitleKey"
        static let loginTitleKey = "loginTitleKey"
    }
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Color(.backgroundAccent)
                    .ignoresSafeArea()
                    .frame(height: 180)
                Spacer()
                    .frame(height: 8)
                Text(String(localized: String.LocalizationValue(Constants.loginTitleKey)))
                    .font(.headingPrimary)
                    .padding(.horizontal, 14)
                Spacer()
                ButtonView(
                    styleType: .primary,
                    content: String(localized: String.LocalizationValue(Constants.loginTitleKey)),
                    action: viewModel.handleLoginButtonDidTap
                )
                .padding(.horizontal, 62)
                Spacer()
                    .frame(height: 54)
            }
            VStack {
                Spacer()
                    .frame(height: 110)
                HStack {
                    Image(.chameleon)
                    Spacer()
                }
                .padding(.horizontal, 14)
                Spacer()
            }
        }
    }
}
