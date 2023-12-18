//
//  LoginViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 18.12.2023.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    private var coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
    func handleLoginButtonDidTap() {
        print(#function)
    }
}
