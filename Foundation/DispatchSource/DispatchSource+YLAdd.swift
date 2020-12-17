//
//  DispatchSource+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/12/15.
//

import UIKit

extension DispatchSource {
    class func dispatchTimer(deadline: DispatchTime, repeating seconds: Int, queue: DispatchQueue, block: @escaping DispatchSourceProtocol.DispatchSourceHandler) -> DispatchSourceTimer {
        let timer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: queue);
        timer.schedule(deadline: deadline, repeating: .milliseconds(Int(seconds) * 1000));
        timer.setEventHandler {
            block();
        }
        return timer;
    }
}
