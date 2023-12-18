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
    
    private var coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.usernameInputText = .empty
        self.passwordInputText = .empty
        self.isUsernameValid = false
        self.isPasswordValid = false
        self.isLoginButtonDisabled = true
    }
    
    func handleLoginButtonDidTap() {
        print(#function)
    }
    
    func handleSignupButtonDidTap() {
        print(#function)
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
    
    private func handleIsUsernameValidDidSet() {
        isLoginButtonDisabled = getIsLoginButtonDisabled() == false
    }
    
    private func handleIsPasswordValidDidSet() {
        isLoginButtonDisabled = getIsLoginButtonDisabled() == false
    }
    
    private func getIsLoginButtonDisabled() -> Bool {
        return isUsernameValid && isPasswordValid
    }
}
