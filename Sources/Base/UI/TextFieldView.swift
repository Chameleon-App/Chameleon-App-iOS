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
    @State private var isInputTextValid: Bool
    @Binding private var inputText: String
    @FocusState private var isFocused: Bool
    
    private let headerText: String
    private let placeholderText: String
    private let validationRules: [TextFieldValidationRule]
    private let handleInputTextDidChangeClosure: Closure.Generic<(newValue: String, isValid: Bool)>?
    
    init(
        inputText: Binding<String>,
        isInputTextValid: Bool = true,
        headerText: String,
        placeholderText: String,
        validationRules: [TextFieldValidationRule] = [],
        handleInputTextDidChangeClosure: Closure.Generic<(newValue: String, isValid: Bool)>? = nil
    ) {
        self._inputText = inputText
        self.isInputTextValid = isInputTextValid
        self.headerText = headerText
        self.placeholderText = placeholderText
        self.validationRules = validationRules
        self.handleInputTextDidChangeClosure = handleInputTextDidChangeClosure
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
                    ZStack(alignment: .topLeading) {
                        Text(placeholderText)
                            .font(.bodyPrimary)
                            .foregroundColor(Color(.textUnaccent))
                            .opacity(inputText.isEmpty && isFocused == false ? 1 : 0)
                            .disabled(true)
                            .animation(.default, value: isFocused)
                        TextEditor(text: $inputText)
                            .focused($isFocused)
                            .font(.bodyPrimary)
                            .foregroundColor(getTextColor(isError: failedRules.isEmpty == false))
                            .tint(Color(.iconPrimary))
                            .scrollContentBackground(.hidden)
                    }
                    if failedRules.isEmpty {
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
                    if failedRules.isEmpty == false {
                        Spacer()
                            .frame(height: 8)
                        Color(.borderPrimary)
                            .frame(height: 1)
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
    
    private func getTextColor(isError: Bool) -> Color {
        if isError {
            return Color(.textAttention)
        } else {
            return Color(.textPrimary)
        }
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
