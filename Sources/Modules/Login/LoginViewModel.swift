//
//  LoginViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var usernameInputText: String
    @Published var isUsernameValid: Bool
    
    private var coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.usernameInputText = .empty
        self.isUsernameValid = true
    }
    
    func handleLoginButtonDidTap() {
        print(#function)
    }
    
    func handleSignupButtonDidTap() {
        print(#function)
    }
}
