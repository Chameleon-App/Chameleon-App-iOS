//
//  LoginView.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI
import PhotosUI

struct LoginView: View {
    private enum Constants {
        static let loginButtonTitleKey = "loginTitle"
        static let loginTitleKey = "loginTitle"
        static let signupTitleKey = "loginScreenSignupTitle"
        static let signupColoredPartTitleKey = "loginScreenSignupColoredPartTitle"
        static let usernameTitleKey = "usernameTitle"
        static let usernamePlaceholderTitleKey = "usernamePlaceholderTitle"
        static let passwordTitleKey = "passwordTitle"
        static let passwordPlaceholderTitleKey = "passwordPlaceholderTitle"
        static let loginErrorTitleKey = "defaultErrorTitle"
        static let loginErrorButtonTitleKey = "defaultErrorButtonTitle"
        static let loginErrorDescriptionKey = "defaultErrorDescription"
    }
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color(.backgroundCommon)
                .resignResponderOnTap()
            VStack(spacing: 0) {
                LoginSignupHeaderView(titleKey: Constants.loginTitleKey)
                Spacer()
                    .frame(height: 16)
                Group {
                    TextFieldView(
                        inputText: $viewModel.usernameInputText,
                        headerText: String(localized: String.LocalizationValue(Constants.usernameTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.usernamePlaceholderTitleKey)
                        ),
                        validationRules: viewModel.getTextFieldsValidationRules(),
                        handleInputTextDidChangeClosure: { viewModel.isUsernameValid = $0.isValid }
                    )
                    TextFieldView(
                        inputText: $viewModel.passwordInputText,
                        headerText: String(localized: String.LocalizationValue(Constants.passwordTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.passwordPlaceholderTitleKey)
                        ),
                        validationRules: viewModel.getTextFieldsValidationRules(),
                        handleInputTextDidChangeClosure: { viewModel.isPasswordValid = $0.isValid },
                        isSecure: true
                    )
                }
                .padding(.horizontal, 12)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.alphabet)
                Spacer()
                LoginSignupBottomView(
                    buttonTitleKey: Constants.loginTitleKey,
                    handleButtonDidTapClosure: viewModel.handleLoginButtonDidTap,
                    isButtonDisabled: viewModel.isLoginButtonDisabled,
                    title: getSignupTitle(),
                    handleTitleDidTapClosure: viewModel.handleSignupButtonDidTap
                )
            }
        }
        .padding(.bottom, 32)
        .ignoresSafeArea()
        .alert(
            String(localized: String.LocalizationValue(Constants.loginErrorTitleKey)),
            isPresented: $viewModel.isErrorAlertPresented,
            actions: {
                Button(
                    String(localized: String.LocalizationValue(Constants.loginErrorButtonTitleKey)),
                    role: .none
                ) {
                    viewModel.handleLoginErrorAlertButtonDidTap()
                }
            },
            message: {
                Text(String(localized: String.LocalizationValue(Constants.loginErrorDescriptionKey)))
                    .foregroundColor(Color(.textPrimary))
            }
        )
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
