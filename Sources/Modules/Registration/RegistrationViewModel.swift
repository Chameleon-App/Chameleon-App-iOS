//
//  RegistrationViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 21.12.2023.
//

import SwiftUI

final class RegistrationViewModel: ObservableObject {
    private let coordinator: RegistrationCoordinator
    
    init(coordinator: RegistrationCoordinator) {
        self.coordinator = coordinator
    }
}
