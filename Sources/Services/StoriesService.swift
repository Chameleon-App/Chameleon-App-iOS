//
//  StoriesService.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import Foundation

enum ProgressMovingDirection {
    case backward
    case forward
}

class StoriesService: TimerService {
    private enum Constants {
        static let storyLengthInSeconds = 5
        static let storyTimerUpdateRateInSeconds = 0.1
        static let progressUpdateValue = storyTimerUpdateRateInSeconds / Double(storyLengthInSeconds)
    }
        
    private var progress = Double.zero
    
    var onProgressChangeAction: Closure.Double?
    
    init() {
        super.init(
            timerInterval: TimeInterval(Constants.storyLengthInSeconds),
            timerUpdateRate: TimeInterval(Constants.storyTimerUpdateRateInSeconds)
        )
    }
    
    override func handleRemainingTimeChange(newRemainingTimeComponents: DateComponents?) {
        progress += Constants.progressUpdateValue
        
        if newRemainingTimeComponents == nil {
            startTimer()
        }
        
        onProgressChangeAction?(progress)
    }
    
    func moveProgress(direction: ProgressMovingDirection) {
        stopTimer()
        
        switch direction {
        case .backward:
            progress = max((progress - .one).rounded(.down), .zero)
        case .forward:
            progress = (progress + .one).rounded(.down)
        }
                
        startTimer()
    }
}
