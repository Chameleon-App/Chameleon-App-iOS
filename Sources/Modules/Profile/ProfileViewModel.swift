//
//  ProfileViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    private var coordinator: ProfileCoordinator

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
}
