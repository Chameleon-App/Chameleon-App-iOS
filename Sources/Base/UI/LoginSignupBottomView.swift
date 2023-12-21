//
//  LoginSignupBottomView.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

struct LoginSignupBottomView: View {
    let buttonTitleKey: String
    let handleButtonDidTapClosure: Closure.Void
    let isButtonDisabled: Bool
    let title: AttributedString
    let handleTitleDidTapClosure: Closure.Void
    
    var body: some View {
        VStack {
            ButtonView(
                styleType: .primary,
                content: String(localized: String.LocalizationValue(buttonTitleKey)),
                action: handleButtonDidTapClosure
            )
            .padding(.horizontal, 62)
            .disabled(isButtonDisabled)
            Spacer()
                .frame(height: 12)
            Text(title)
                .font(.bodySmall)
                .onTapGesture(perform: handleTitleDidTapClosure)
        }
    }
}
