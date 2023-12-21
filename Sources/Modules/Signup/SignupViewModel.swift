//
//  SignupViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

final class SignupViewModel: ObservableObject {
    private enum Constants {
        static let minUsernameLength = 1
        static let maxUsernameLength = 150
        static let minPasswordLength = 1
        static let maxPasswordLength = 128
        static let maxLengthRuleTitleKey = "maxLengthRuleTitle"
        static let minLengthRuleTitleKey = "minLengthRuleTitle"
    }
    
    @Published var usernameInputText: String
    @Published var isUsernameValid: Bool { didSet { handleIsUsernameValidDidSet() } }
    @Published var passwordInputText: String
    @Published var isPasswordValid: Bool { didSet { handleIsPasswordValidDidSet() } }
    @Published var isSignupButtonDisabled: Bool
    
    private let coordinator: SignupCoordinator
    
    init(coordinator: SignupCoordinator) {
        self.coordinator = coordinator
        self.usernameInputText = .empty
        self.isUsernameValid = false
        self.passwordInputText = .empty
        self.isPasswordValid = false
        self.isSignupButtonDisabled = true
    }
    
    func handleSignupButtonDidTap() {
        
    }
    
    func handleLoginTitleDidTap() {
        openLoginScreen()
    }
    
    func getUsernameFieldValidationRules() -> [TextFieldValidationRule] {
        let minLengthRule = TextFieldValidationRule.minLength(
            count: Constants.minUsernameLength,
            message: String(
                localized: String.LocalizationValue(Constants.minLengthRuleTitleKey)
            ) + String(Constants.minUsernameLength)
        )
        
        let maxLenghtRult = TextFieldValidationRule.minLength(
            count: Constants.maxUsernameLength,
            message: String(
                localized: String.LocalizationValue(Constants.maxLengthRuleTitleKey)
            ) + String(Constants.maxUsernameLength)
        )
        
        return [minLengthRule, maxLenghtRult]
    }
    
    func getPasswordFieldValidationRules() -> [TextFieldValidationRule] {
        let minLengthRule = TextFieldValidationRule.minLength(
            count: Constants.minUsernameLength,
            message: String(
                localized: String.LocalizationValue(Constants.minLengthRuleTitleKey)
            ) + String(Constants.minUsernameLength)
        )
        
        let maxLenghtRult = TextFieldValidationRule.minLength(
            count: Constants.maxPasswordLength,
            message: String(
                localized: String.LocalizationValue(Constants.maxLengthRuleTitleKey)
            ) + String(Constants.maxPasswordLength)
        )
        
        return [minLengthRule, maxLenghtRult]
    }
    
    private func openLoginScreen() {
        Task { @MainActor in coordinator.openLoginScreen() }
    }
    
    private func handleIsUsernameValidDidSet() {
        
    }
    
    private func handleIsPasswordValidDidSet() {
        
    }
}
