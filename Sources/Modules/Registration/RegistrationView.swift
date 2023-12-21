//
//  RegistrationView.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LoginRegistrationHeaderView()
                    .ignoresSafeArea()
            }
        }
    }
}
