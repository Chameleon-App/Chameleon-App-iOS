//
//  PantonesStoriesViewModel.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import Foundation

final class PantonesStoriesViewModel: ObservableObject {
    private enum Constants {
        static let minDragWidthToSwipe: CGFloat = 50
    }
    
    @Published var progress = Double.zero
    
    let pantonesOfDay: PantonesOfDayModel
    var currentStoryNumber: Int { Int(progress) }
    
    private let coordinator: PantonesStoriesCoordinator
    private let storiesService: StoriesService
    private var storiesCount = Int.zero
    
    init(coordinator: PantonesStoriesCoordinator, pantonesOfDay: PantonesOfDayModel) {
        self.coordinator = coordinator
        self.pantonesOfDay = pantonesOfDay
        self.storiesService = StoriesService()
        
        self.storiesService.onProgressChangeAction = { [weak self] in self?.handleProgressChange(newProgress: $0) }
    }
    
    func handleGoToNextStory() {
        storiesService.moveProgress(direction: .forward)
    }
    
    func handleDragGesture(with width: CGFloat) {
        if abs(width) > Constants.minDragWidthToSwipe {
            let direction: ProgressMovingDirection = width < 0 ? .forward : .backward
            
            storiesService.moveProgress(direction: direction)
        }
    }

    func handleStoriesClose() {
        storiesService.stopTimer()
        
        coordinator.dismiss()
    }
    
    func handleStoriesViewAppear(storiesCount: Int) {
        self.storiesCount = storiesCount
        
        storiesService.startTimer()
    }
    
    func handleStoriesViewDisappear() {
        storiesService.stopTimer()
    }
    
    private func handleProgressChange(newProgress: Double) {
        if newProgress >= Double(storiesCount) {
            handleStoriesClose()
        } else {
            progress = newProgress
        }
    }
}
