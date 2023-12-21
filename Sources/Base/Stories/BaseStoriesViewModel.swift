//
//  BaseStoriesViewModel.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import Foundation

class BaseStoriesViewModel: ObservableObject {
    private enum Constants {
        static let minDragWidthToSwipe: CGFloat = 50
    }
    
    @Published var progress = Double.zero
    
    var currentStoryNumber: Int { Int(progress) }
    
    private let storiesService: StoriesService
    private var storiesCount = Int.zero
        
    init(storiesService: StoriesService) {
        self.storiesService = storiesService
        
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
