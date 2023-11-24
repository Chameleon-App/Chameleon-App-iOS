//
//  CalendarViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    private var coordinator: CalendarCoordinator

    init(coordinator: CalendarCoordinator) {
        self.coordinator = coordinator
    }
}
