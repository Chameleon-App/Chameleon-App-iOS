//
//  SignupViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

final class SignupViewModel: ObservableObject {
    @Published var isSignupButtonDisabled: Bool
    
    private let coordinator: SignupCoordinator
    
    init(coordinator: SignupCoordinator) {
        self.coordinator = coordinator
        self.isSignupButtonDisabled = true
    }
    
    func handleSignupButtonDidTap() {
        
    }
    
    func handleLoginTitleDidTap() {
        openLoginScreen()
    }
    
    private func openLoginScreen() {
        Task { @MainActor in coordinator.openLoginScreen() }
    }
}
