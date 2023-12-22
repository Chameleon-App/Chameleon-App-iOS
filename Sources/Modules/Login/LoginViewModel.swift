//
//  LoginViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    private enum Constants {
        static let minimumUsernameLength = 1
        static let minLengthRuleTitleKey = "minLengthRuleTitle"
    }
    
    @Published var usernameInputText: String
    @Published var isUsernameValid: Bool { didSet { handleIsUsernameValidDidSet() } }
    @Published var passwordInputText: String
    @Published var isPasswordValid: Bool { didSet { handleIsPasswordValidDidSet() } }
    @Published var isLoginButtonDisabled: Bool
    @Published var isErrorAlertPresented: Bool
    
    private let coordinator: LoginCoordinator
    private let authenticationRepository: AuthenticationRepository

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.authenticationRepository = AuthenticationRepository()
        self.usernameInputText = .empty
        self.passwordInputText = .empty
        self.isUsernameValid = false
        self.isPasswordValid = false
        self.isLoginButtonDisabled = true
        self.isErrorAlertPresented = false
    }
    
    func handleLoginButtonDidTap() {
        login()
    }
    
    func handleSignupButtonDidTap() {
        openSignupScreen()
    }
    
    func getTextFieldsValidationRules() -> [TextFieldValidationRule] {
        let minLengthRule = TextFieldValidationRule.minLength(
            count: Constants.minimumUsernameLength,
            message: String(
                localized: String.LocalizationValue(Constants.minLengthRuleTitleKey)
            ) + String(Constants.minimumUsernameLength)
        )
        
        return [minLengthRule]
    }
    
    func handleLoginErrorAlertButtonDidTap() {
        isErrorAlertPresented = false
    }
    
    private func handleIsUsernameValidDidSet() {
        isLoginButtonDisabled = getIsLoginButtonDisabled() == false
    }
    
    private func handleIsPasswordValidDidSet() {
        isLoginButtonDisabled = getIsLoginButtonDisabled() == false
    }
    
    private func getIsLoginButtonDisabled() -> Bool {
        return isUsernameValid && isPasswordValid
    }
    
    private func login() {
        Task {
            switch await authenticationRepository.login(username: usernameInputText, password: passwordInputText) {
            case .success:
                handleLoginSuccess()
            case .failure(let error):
                handleLoginError(error)
            }
        }
    }
    
    private func handleLoginSuccess() {
        openMainScreen()
    }
    
    private func handleLoginError(_ error: ServerClientServiceError) {
        Task { @MainActor in isErrorAlertPresented = true }
    }
    
    private func openMainScreen() {
        Task { @MainActor in coordinator.openMainScreen() }
    }
    
    private func openSignupScreen() {
        Task { @MainActor in coordinator.openSignupScreen() }
    }
}
