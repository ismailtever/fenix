//
//  Debouncer.swift
//  fenix
//
//  Created by Ismail Tever on 9.12.2023.
//

import Foundation

final class Debouncer {
    
    var callback: (() -> Void)?
    var delay: TimeInterval
    var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func debounce(_ callback: @escaping (() -> Void)) {
        self.callback = callback
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(fireCallback), userInfo: nil, repeats: false)
    }
    
    @objc private func fireCallback() {
        callback?()
    }
}

