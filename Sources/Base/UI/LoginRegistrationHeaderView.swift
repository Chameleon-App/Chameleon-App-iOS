//
//  LoginRegistrationHeaderView.swift
//  chameleon
//
//  Created by Илья Чуб on 21.12.2023.
//

import SwiftUI

struct LoginRegistrationHeaderView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 110)
            HStack {
                Image(.chameleon)
                Spacer()
            }
            .padding(.horizontal, 14)
            Spacer()
        }
    }
}
