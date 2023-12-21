//
//  SignupView.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

struct SignupView: View {
    private enum Constants {
        static let signupTitleKey = "signupTitle"
        static let loginTitleKey = "signupScreenLoginTitle"
        static let loginColoredPartTitleKey = "signupScreenLoginColoredPartTitle"
        static let signupButtonTitleKey = "signupButtonTitle"
    }
    
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    LoginSignupHeaderView(titleKey: Constants.signupTitleKey)
                }
            }
            .ignoresSafeArea()
            LoginSignupBottomView(
                buttonTitleKey: Constants.signupButtonTitleKey,
                handleButtonDidTapClosure: viewModel.handleSignupButtonDidTap,
                isButtonDisabled: viewModel.isSignupButtonDisabled,
                title: getLoginTitle(),
                handleTitleDidTapClosure: viewModel.handleLoginTitleDidTap
            )
        }
    }
    
    private func getLoginTitle() -> AttributedString {
        let string = String(localized: String.LocalizationValue(Constants.loginTitleKey))
        var attributedString = AttributedString(string)
        
        attributedString.foregroundColor = Color(.textUnaccent)
        
        let coloredPart = String(localized: String.LocalizationValue(Constants.loginColoredPartTitleKey))
        if let range = attributedString.range(of: coloredPart) {
            attributedString[range].foregroundColor = Color(.textLink)
        }
        
        return attributedString
    }
}
