//
//  LoginView.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI

struct LoginView: View {
    private enum Constants {
        static let loginButtonTitleKey = "loginTitle"
        static let loginTitleKey = "loginTitle"
        static let signupTitleKey = "loginScreenSignupTitle"
        static let signupColoredPartTitleKey = "loginScreenSignupColoredPartTitle"
    }
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Color(.backgroundAccent)
                    .ignoresSafeArea()
                    .frame(height: 180)
                Spacer()
                    .frame(height: 8)
                HStack {
                    Text(String(localized: String.LocalizationValue(Constants.loginTitleKey)))
                        .font(.headingPrimary)
                        .padding(.horizontal, 14)
                    Spacer()
                }
                Spacer()
                ButtonView(
                    styleType: .primary,
                    content: String(localized: String.LocalizationValue(Constants.loginTitleKey)),
                    action: viewModel.handleLoginButtonDidTap
                )
                .padding(.horizontal, 62)
                Spacer()
                    .frame(height: 12)
                Text(getSignupTitle())
                    .font(.bodySmall)
                    .onTapGesture(perform: viewModel.handleSignupButtonDidTap)
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
    
    private func getSignupTitle() -> AttributedString {
        let string = String(localized: String.LocalizationValue(Constants.signupTitleKey))
        var attributedString = AttributedString(string)
        
        attributedString.foregroundColor = Color(.textUnaccent)
        
        let coloredPart = String(localized: String.LocalizationValue(Constants.signupColoredPartTitleKey))
        if let range = attributedString.range(of: coloredPart) {
            attributedString[range].foregroundColor = Color(.textLink)
        }
        
        return attributedString
    }
}
