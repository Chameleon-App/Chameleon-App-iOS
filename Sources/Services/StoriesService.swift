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

final class StoriesService {
    private enum Constants {
        static let storyLengthInSeconds = 5
        static let storyTimerUpdateRateInSeconds = 0.1
        static let progressUpdateValue = storyTimerUpdateRateInSeconds / Double(storyLengthInSeconds)
    }
    
    var isTimerPassed: Bool { currentDate >= endDate }
    var isItFirstTimerStart: Bool { timer == nil }
        
    private let calendar = Calendar.current
    
    private let timerInterval = TimeInterval(Constants.storyLengthInSeconds)
    private let timerUpdateRate = TimeInterval(Constants.storyTimerUpdateRateInSeconds)
    
    private var timer: Timer?
    private var endDate = Date()
    private var currentDate = Date()
    
    private var progress = Double.zero
    
    var onProgressChangeAction: Closure.Double?
    
    func handleRemainingTimeChange(newRemainingTimeComponents: DateComponents?) {
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
    
    func startTimer(currentDate: Date = .now, endDate: Date? = nil) {
        self.currentDate = currentDate
        self.endDate = endDate ?? (currentDate + timerInterval)
        
        handleRemainingTimeChange(newRemainingTimeComponents: getRemainingTime())
        
        self.timer = Timer.scheduledTimer(withTimeInterval: timerUpdateRate, repeats: true) { [weak self] _ in
            guard let self else {
                return
            }
            
            self.currentDate.addTimeInterval(timerUpdateRate)
            
            handleRemainingTimeChange(newRemainingTimeComponents: getRemainingTime())
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func getRemainingTime() -> DateComponents? {
        guard currentDate < endDate else {
            stopTimer()
            
            return nil
        }
        
        return calendar.dateComponents([.minute, .second], from: currentDate, to: endDate)
    }
}
