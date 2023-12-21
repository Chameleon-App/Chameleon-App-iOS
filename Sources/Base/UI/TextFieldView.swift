//
//  TextFieldView.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI
import FormView

enum TextFieldValidationRule {
    case minLength(count: Int, message: String)
    case maxLength(count: Int, message: String)
    case notEmpty(message: String)
    case email(message: String)
}

struct TextFieldView: View {
    @Binding private var inputText: String
    @FocusState private var isFocused: Bool
    
    private let headerText: String
    private let placeholderText: String
    private let validationRules: [TextFieldValidationRule]
    private let handleInputTextDidChangeClosure: Closure.Generic<(newValue: String, isValid: Bool)>?
    private let isSecure: Bool
    
    init(
        inputText: Binding<String>,
        headerText: String,
        placeholderText: String,
        validationRules: [TextFieldValidationRule] = [],
        handleInputTextDidChangeClosure: Closure.Generic<(newValue: String, isValid: Bool)>? = nil,
        isSecure: Bool = false
    ) {
        self._inputText = inputText
        self.headerText = headerText
        self.placeholderText = placeholderText
        self.validationRules = validationRules
        self.handleInputTextDidChangeClosure = handleInputTextDidChangeClosure
        self.isSecure = isSecure
    }
    
    var body: some View {
        FormView(hideError: .onFocus) { validator in
            FormField(value: $inputText, rules: getTextValidationRules()) { failedRules in
                VStack(spacing: 0) {
                    Text(headerText)
                        .foregroundColor(Color(.textPrimary))
                        .font(.subheadingPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    Spacer()
                        .frame(height: 8)
                    Group {
                        if isSecure {
                            SecureField(placeholderText, text: $inputText)
                        } else {
                            TextField(placeholderText, text: $inputText)
                        }
                    }
                    .keyboardType(.alphabet)
                    .focused($isFocused)
                    .font(.bodyPrimary)
                    .foregroundColor(Color(.textPrimary))
                    .tint(Color(.iconPrimary))
                    .scrollContentBackground(.hidden)
                    if failedRules.isEmpty {
                        Spacer()
                            .frame(height: 2)
                        Color(.borderPrimary)
                            .frame(height: 1)
                    }
                    Spacer()
                        .frame(height: 8)
                    Text(failedRules.first(where: { $0.message != .empty })?.message ?? .empty)
                        .foregroundColor(Color(.textAttention))
                        .font(.bodySmall)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(failedRules.isEmpty ? 0 : 1)
                    Group {
                        if failedRules.isEmpty == false {
                            Spacer()
                                .frame(height: 8)
                            Color(.borderPrimary)
                                .frame(height: 1)
                        }
                    }
                }
                .animation(.default, value: failedRules.isEmpty)
                .onChange(of: inputText) {
                    handleInputTextDidChangeClosure?((newValue: inputText, isValid: validator.validate()))
                }
            }
        }
        .frame(height: 76)
    }
    
    private func getTextValidationRules() -> [TextValidationRule] {
        return validationRules.compactMap {
            switch $0 {
            case .maxLength(let count, let message):
                return .maxLength(count: count, message: message)
            case .minLength(let count, let message):
                return .minLength(count: count, message: message)
            case .notEmpty(let message):
                return .notEmpty(message: message)
            case .email(let message):
                return .email(message: message)
            }
        }
    }
}
