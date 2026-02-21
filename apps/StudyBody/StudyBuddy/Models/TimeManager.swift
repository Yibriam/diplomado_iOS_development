//
//  TimeManager.swift
//  StudyBody
//
//  Created by Yibriam on 07/02/26.
//

import SwiftUI

@Observable
class TimeManager {
    var totalSeconds: Int = 25 * 60
    var remainingSeconds: Int = 25 * 60
    var isRunning: Bool = false
    private var  timer
    
    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        
        return Double(totalSeconds - remainingSeconds)/Double(totalSeconds)
    }
    
    var timeString: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
        
    }
    
    func start() {
        guard isRunning else { return }
        
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in guard let self = self else { return }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.pause()
            }
        })
    }
    
    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        pause()
        remainingSeconds = totalSeconds
    }
    
    func setDuration(minutes: Int) {
        
    }
}
