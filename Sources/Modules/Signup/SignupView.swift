//
//  SignupView.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import FormView
import SwiftUI
import PhotosUI
import SwiftyCrop

struct SignupView: View {
    private enum Constants {
        static let signupTitleKey = "signupTitle"
        static let loginTitleKey = "signupScreenLoginTitle"
        static let loginColoredPartTitleKey = "signupScreenLoginColoredPartTitle"
        static let signupButtonTitleKey = "signupButtonTitle"
        static let usernameTitleKey = "usernameTitle"
        static let usernamePlaceholderTitleKey = "usernamePlaceholderTitle"
        static let passwordTitleKey = "passwordTitle"
        static let passwordPlaceholderTitleKey = "passwordPlaceholderTitle"
        static let emailTitleKey = "emailTitle"
        static let emailPlaceholderTitleKey = "emailPlaceholderTitle"
        static let checkPasswordTitleKey = "checkPasswordTitle"
        static let checkPasswordPlaceholderTitleKey = "checkPasswordPlaceholderTitle"
    }
    
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        ZStack {
            Color(.backgroundCommon)
                .resignResponderOnTap()
            VStack(spacing: 0) {
                LoginSignupHeaderView(titleKey: Constants.signupTitleKey)
                Spacer()
                    .frame(height: 16)
                PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                    Group {
                        if let selectedImage = viewModel.selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                        } else {
                            ZStack {
                                Color(.backgroundAccent)
                                Image(.ic32CameraFit)
                            }
                        }
                    }
                    .frame(width: 125, height: 125)
                    .cornerRadius(.infinity)
                }
                .photosPickerDisabledCapabilities(.collectionNavigation)
                Spacer()
                    .frame(height: 16)
                Group {
                    TextFieldView(
                        inputText: $viewModel.emailInputText,
                        headerText: String(localized: String.LocalizationValue(Constants.emailTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.emailPlaceholderTitleKey)
                        ),
                        validationRules: viewModel.getEmailFieldValidationRules(),
                        handleInputTextDidChangeClosure: { viewModel.isEmailValid = $0.isValid }
                    )
                    TextFieldView(
                        inputText: $viewModel.usernameInputText,
                        headerText: String(localized: String.LocalizationValue(Constants.usernameTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.usernamePlaceholderTitleKey)
                        ),
                        validationRules: viewModel.getUsernameFieldValidationRules(),
                        handleInputTextDidChangeClosure: { viewModel.isUsernameValid = $0.isValid }
                    )
                    TextFieldView(
                        inputText: $viewModel.passwordInputText,
                        headerText: String(localized: String.LocalizationValue(Constants.passwordTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.passwordPlaceholderTitleKey)
                        ),
                        validationRules: viewModel.getPasswordFieldValidationRules(),
                        handleInputTextDidChangeClosure: { viewModel.isPasswordValid = $0.isValid },
                        isSecure: true
                    )
                    TextFieldView(
                        inputText: $viewModel.checkPasswordInputText,
                        headerText: String(localized: String.LocalizationValue(Constants.checkPasswordTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.checkPasswordPlaceholderTitleKey)
                        ),
                        validationRules: [],
                        handleInputTextDidChangeClosure: nil,
                        isSecure: true
                    )
                }
                .padding(.horizontal, 12)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.alphabet)
                Spacer()
                LoginSignupBottomView(
                    buttonTitleKey: Constants.signupButtonTitleKey,
                    handleButtonDidTapClosure: viewModel.handleSignupButtonDidTap,
                    isButtonDisabled: viewModel.isSignupButtonDisabled,
                    title: getLoginTitle(),
                    handleTitleDidTapClosure: viewModel.handleLoginTitleDidTap
                )
            }
        }
        .padding(.bottom, 32)
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $viewModel.isNeedToShowCropScreen) {
            if let selectedImage = viewModel.selectedImage {
                SwiftyCropView(imageToCrop: selectedImage, maskShape: .circle) {
                    viewModel.handleImageDidCrop($0)
                }
            }
        }
        .animation(.default, value: viewModel.selectedImage)
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
