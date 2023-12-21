//
//  PantonesStoriesViewModel.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import Foundation

final class PantonesStoriesViewModel: BaseStoriesViewModel {
    let pantonesOfDay: PantonesOfDayModel
    
    private let coordinator: PantonesStoriesCoordinator
    
    init(coordinator: PantonesStoriesCoordinator, pantonesOfDay: PantonesOfDayModel) {
        self.coordinator = coordinator
        self.pantonesOfDay = pantonesOfDay
        
        super.init(storiesService: StoriesService())
    }
    
    override func handleStoriesClose() {
        super.handleStoriesClose()
        
        coordinator.dismiss()
    }
}
