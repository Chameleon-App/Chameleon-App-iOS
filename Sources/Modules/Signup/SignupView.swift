//
//  SignupView.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

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
    }
    
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    LoginSignupHeaderView(titleKey: Constants.signupTitleKey)
                }
                Spacer()
                    .frame(height: 34)
                
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
                        inputText: $viewModel.usernameInputText,
                        isInputTextValid: viewModel.isUsernameValid,
                        headerText: String(localized: String.LocalizationValue(Constants.usernameTitleKey)),
                        placeholderText: String(
                            localized: String.LocalizationValue(Constants.usernamePlaceholderTitleKey)
                        ),
                        validationRules: viewModel.getUsernameFieldValidationRules(),
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
                        validationRules: viewModel.getPasswordFieldValidationRules(),
                        handleInputTextDidChangeClosure: { viewModel.isPasswordValid = $0.isValid }
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                }
                .padding(.horizontal, 12)
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
