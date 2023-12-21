//
//  SignupViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI
import PhotosUI

final class SignupViewModel: ObservableObject {
    private enum Constants {
        static let minUsernameLength = 1
        static let maxUsernameLength = 150
        static let minPasswordLength = 1
        static let maxPasswordLength = 128
        static let minEmailLength = 1
        static let maxEmailLength = 254
        static let maxLengthRuleTitleKey = "maxLengthRuleTitle"
        static let minLengthRuleTitleKey = "minLengthRuleTitle"
    }
    
    @Published var isNeedToShowCropScreen: Bool
    @Published var selectedPhotoItem: PhotosPickerItem? { didSet { handleSelectedPhotoItemDidSet() } }
    @Published var selectedImage: UIImage?
    @Published var usernameInputText: String
    @Published var isUsernameValid: Bool { didSet { handleIsUsernameValidDidSet() } }
    @Published var passwordInputText: String
    @Published var isPasswordValid: Bool { didSet { handleIsPasswordValidDidSet() } }
    @Published var emailInputText: String
    @Published var isEmailValid: Bool { didSet { handleIsEmailValidDidSet() } }
    @Published var isSignupButtonDisabled: Bool
    
    private let coordinator: SignupCoordinator
    
    init(coordinator: SignupCoordinator) {
        self.coordinator = coordinator
        self.usernameInputText = .empty
        self.isUsernameValid = false
        self.passwordInputText = .empty
        self.isPasswordValid = false
        self.emailInputText = .empty
        self.isEmailValid = false
        self.isSignupButtonDisabled = true
        self.isNeedToShowCropScreen = false
    }
    
    func handleSignupButtonDidTap() {
        
    }
    
    func handleLoginTitleDidTap() {
        openLoginScreen()
    }
    
    func getEmailFieldValidationRules() -> [TextFieldValidationRule] {
        let minLengthRule = TextFieldValidationRule.minLength(
            count: Constants.minEmailLength,
            message: String(
                localized: String.LocalizationValue(Constants.minLengthRuleTitleKey)
            ) + String(Constants.minEmailLength)
        )
        
        let maxLenghtRult = TextFieldValidationRule.minLength(
            count: Constants.maxEmailLength,
            message: String(
                localized: String.LocalizationValue(Constants.maxLengthRuleTitleKey)
            ) + String(Constants.maxEmailLength)
        )
        
        return [minLengthRule, maxLenghtRult]
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
    
    func handleImageDidCrop(_ image: UIImage?) {
        isNeedToShowCropScreen = false
        selectedImage = image
    }
    
    private func openLoginScreen() {
        Task { @MainActor in coordinator.openLoginScreen() }
    }
    
    private func handleIsUsernameValidDidSet() {
        
    }
    
    private func handleIsPasswordValidDidSet() {
        
    }
    
    private func handleIsEmailValidDidSet() {
        
    }
    
    private func handleSelectedPhotoItemDidSet() {
        Task {
            guard
                let imageData = try? await selectedPhotoItem?.loadTransferable(type: Data.self),
                let image = UIImage(data: imageData)
            else {
                return handleError()
            }
            
            Task { @MainActor in
                self.selectedPhotoItem = nil
                self.selectedImage = image
                self.isNeedToShowCropScreen = true
            }
        }
    }
    
    private func handleError() {
        
    }
}
