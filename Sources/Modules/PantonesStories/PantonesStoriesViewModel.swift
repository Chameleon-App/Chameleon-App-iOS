//
//  PantonesStoriesViewModel.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import Foundation

final class PantonesStoriesViewModel: ObservableObject {
    private let coordinator: PantonesStoriesCoordinator
    
    init(coordinator: PantonesStoriesCoordinator) {
        self.coordinator = coordinator
    }
}
