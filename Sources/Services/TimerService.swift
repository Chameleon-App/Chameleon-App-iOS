//
//  TimerService.swift
//  chameleon
//
//  Created by Pavlentiy on 22.12.2023.
//

import Foundation

class TimerService {
    var isTimerPassed: Bool { currentDate >= endDate }
    var isItFirstTimerStart: Bool { timer == nil }
        
    private let calendar = Calendar.current
    
    private let timerInterval: TimeInterval
    private let timerUpdateRate: TimeInterval
    
    private var timer: Timer?
    private var endDate = Date()
    private var currentDate = Date()
    
    init(timerInterval: TimeInterval, timerUpdateRate: TimeInterval) {
        self.timerInterval = timerInterval
        self.timerUpdateRate = timerUpdateRate
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
    
    func handleRemainingTimeChange(newRemainingTimeComponents: DateComponents?) {
        assertionFailure("This method should be overridden in the child class")
    }
    
    func getRemainingTime() -> DateComponents? {
        guard currentDate < endDate else {
            stopTimer()
            
            return nil
        }
        
        return calendar.dateComponents([.minute, .second], from: currentDate, to: endDate)
    }
}
