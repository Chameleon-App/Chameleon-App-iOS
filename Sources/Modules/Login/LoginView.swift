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
        static let usernameTitleKey = "usernameTitle"
        static let usernamePlaceholderTitleKey = "usernamePlaceholderTitle"
        static let passwordTitleKey = "passwordTitle"
        static let passwordPlaceholderTitleKey = "passwordPlaceholderTitle"
        static let loginErrorTitleKey = "defaultErrorTitle"
        static let loginErrorButtonTitleKey = "loginErrorButtonTitle"
        static let loginErrorDescriptionKey = "defaultErrorDescription"
    }
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
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
                            .frame(height: 34)
                        Group {
                            TextFieldView(
                                inputText: $viewModel.usernameInputText,
                                isInputTextValid: viewModel.isUsernameValid,
                                headerText: String(localized: String.LocalizationValue(Constants.usernameTitleKey)),
                                placeholderText: String(
                                    localized: String.LocalizationValue(Constants.usernamePlaceholderTitleKey)
                                ),
                                validationRules: viewModel.getTextFieldsValidationRules(),
                                handleInputTextDidChangeClosure: { viewModel.isUsernameValid = $0.isValid }
                            )
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            TextFieldView(
                                inputText: $viewModel.passwordInputText,
                                isInputTextValid: viewModel.isPasswordValid,
                                headerText: String(localized: String.LocalizationValue(Constants.passwordTitleKey)),
                                placeholderText: String(
                                    localized: String.LocalizationValue(Constants.passwordPlaceholderTitleKey)
                                ),
                                validationRules: viewModel.getTextFieldsValidationRules(),
                                handleInputTextDidChangeClosure: { viewModel.isPasswordValid = $0.isValid }
                            )
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        }
                        .padding(.horizontal, 12)
                    }
                    LoginRegistrationHeaderView()
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
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                ButtonView(
                    styleType: .primary,
                    content: String(localized: String.LocalizationValue(Constants.loginTitleKey)),
                    action: viewModel.handleLoginButtonDidTap
                )
                .padding(.horizontal, 62)
                .disabled(viewModel.isLoginButtonDisabled)
                Spacer()
                    .frame(height: 12)
                Text(getSignupTitle())
                    .font(.bodySmall)
                    .onTapGesture(perform: viewModel.handleSignupButtonDidTap)
                Spacer()
                    .frame(height: 24)
            }
        }
        .resignResponderOnTap()
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
