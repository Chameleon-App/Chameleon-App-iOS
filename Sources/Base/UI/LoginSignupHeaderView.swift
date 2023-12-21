//
//  LoginSignupHeaderView.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

struct LoginSignupHeaderView: View {
    let titleKey: String
    
    var body: some View {
        ZStack {
            VStack {
                Color(.backgroundAccent)
                    .frame(height: 180)
                Spacer()
            }
            VStack {
                Spacer()
                    .frame(height: 110)
                HStack {
                    Image(.chameleon)
                    Spacer()
                }
                .padding(.horizontal, 14)
                .zIndex(1)
                HStack {
                    Text(String(localized: String.LocalizationValue(titleKey)))
                        .font(.headingPrimary)
                        .padding(.horizontal, 14)
                        .zIndex(0.1)
                    Spacer()
                }
                .padding(.top, -58)
            }
        }
        .frame(height: 180)
    }
}
