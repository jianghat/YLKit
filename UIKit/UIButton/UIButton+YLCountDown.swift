//
//  UIButton+YLCountDown.swift
//  Driver
//
//  Created by ym on 2020/9/30.
//

import UIKit

extension UIButton {
    @discardableResult
    func startCountDown(_ timeOut: Int, title: String, format: String) -> DispatchSourceTimer {
        var timeout: Int = timeOut; //倒计时时间
        let timer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .milliseconds(1000))
        timer.setEventHandler {[weak self] in
            timeout -= 1
            DispatchQueue.main.async {
                self?.isUserInteractionEnabled = false
            }
            if timeout < 0 {
                timer.cancel();
                DispatchQueue.main.async {
                    self?.isUserInteractionEnabled = true
                    self?.setTitle(title, for: .normal)
                }
                return
            }
            DispatchQueue.main.async {
                let t = String(format: format, timeout);
                self?.setTitle(t, for: .normal);
            }
        }
        timer.resume();
        return timer;
    }
}
