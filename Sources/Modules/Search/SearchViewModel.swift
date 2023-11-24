//
//  SearchViewModel.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    private var coordinator: SearchCoordinator

    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
    }
}
