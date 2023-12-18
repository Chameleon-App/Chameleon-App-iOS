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
                VStack(spacing: 8) {
                    Text(headerText)
                        .foregroundColor(Color(.textPrimary))
                        .font(.subheadingPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    ZStack(alignment: .topLeading) {
                        if isFocused == false {
                            Text(placeholderText)
                                .font(.bodyPrimary)
                                .foregroundColor(Color(.textUnaccent))
                                .opacity(inputText.isEmpty ? 1 : 0)
                                .disabled(true)
                        }
                        TextEditor(text: $inputText)
                            .focused($isFocused)
                            .font(.bodyPrimary)
                            .foregroundColor(getTextColor(isError: failedRules.isEmpty == false))
                            .tint(Color(.iconPrimary))
                            .scrollContentBackground(.hidden)
                    }
                    if let firstErrorMessage = failedRules.first(where: { $0.message != .empty })?.message {
                        Text(firstErrorMessage)
                            .foregroundColor(Color(.textAttention))
                            .font(.bodySmall)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Color(.borderPrimary)
                        .frame(height: 1)
                }
                .animation(.default, value: isFocused)
                .animation(.default, value: failedRules.isEmpty == false)
                .onChange(of: inputText) {
                    handleInputTextDidChangeClosure?((newValue: inputText, isValid: validator.validate()))
                }
            }
        }
    }
    
    private func getTextColor(isError: Bool) -> Color {
        if isError {
            return Color(.textAttention)
        } else if isFocused || inputText.isEmpty {
            return Color(.textPrimary)
        } else {
            return .white
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
            }
        }
    }
}
