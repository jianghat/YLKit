//
//  YLLaunchAdButton.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import UIKit

/**
 *  倒计时类型
 */
enum YLSkipType {
    case None//无
    case Time //方形:倒计时
    case Text //方形:跳过
    case TimeText //方形:倒计时+跳过 (default)
    case RoundTime //圆形:倒计时
    case RoundText //圆形:跳过
    case RoundProgressTime //圆形:进度圈+倒计时
    case RoundProgressText //圆形:进度圈+跳过
}

class YLLaunchAdButton: UIButton {
    var leftRightSpace: CGFloat = 5 {
        didSet {
            var frame: CGRect  = self.timeLabel.frame
            let width: CGFloat = frame.size.width
            if leftRightSpace <= 0 || leftRightSpace*2 >= width {
                return
            }
            frame = CGRect(x: leftRightSpace, y: frame.origin.y, width: width-2*leftRightSpace, height: frame.size.height);
            self.timeLabel.frame = frame
            self.cornerRadiusWithView(self.timeLabel)
        }
    }
    
    var topBottomSpace: CGFloat = 2.5 {
        didSet {
            var frame: CGRect  = self.timeLabel.frame
            let height: CGFloat = frame.size.height
            if(topBottomSpace <= 0 || topBottomSpace*2 >= height) {
                return
            }
            frame = CGRect(x: frame.origin.x, y: topBottomSpace, width: frame.size.width, height: height-2*topBottomSpace);
            self.timeLabel.frame = frame
            self.cornerRadiusWithView(self.timeLabel)
        }
    }
    
    var skipType: YLSkipType = .TimeText
    var roundTimer: DispatchSourceTimer?
    
    // Mark LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.stopTimer()
    }
    
    convenience init(skipType: YLSkipType) {
        let y: CGFloat = YL_IS_IPhoneX_All ? 44 : 20
        //环形
        if(skipType == .RoundTime || skipType == .RoundText || skipType == .RoundProgressTime || skipType == .RoundProgressText){
            self.init(frame:CGRect(x: YLScreenWidth-55, y: y, width: 42, height: 42))
        } else {//方形
            self.init(frame:CGRect(x: YLScreenWidth-80, y: y, width: 70, height: 35))
        }
        self.skipType = skipType
        switch skipType {
        case .None:
            self.isHidden = true
        case .Time:
            self.addSubview(self.timeLabel)
            self.leftRightSpace = 5;
            self.topBottomSpace = 2.5
        case .Text:
            self.addSubview(self.timeLabel)
            self.leftRightSpace = 5;
            self.topBottomSpace = 2.5
        case .TimeText:
            self.addSubview(self.timeLabel)
            self.leftRightSpace = 5
            self.topBottomSpace = 2.5
        case .RoundTime:
            self.addSubview(self.timeLabel)
        case .RoundText:
            self.addSubview(self.timeLabel)
        case .RoundProgressTime:
            self.addSubview(self.timeLabel)
            self.timeLabel.layer.addSublayer(self.roundLayer)
        case .RoundProgressText:
            self.addSubview(self.timeLabel)
            self.timeLabel.layer.addSublayer(self.roundLayer)
        }
    }
    
    public func setTitleWithSkipType(skipType: YLSkipType, duration: Int) {
        let skipTitle: String = "跳过"
        let durationUnit: String = "S"
        switch skipType {
        case .None:
            self.isHidden = true
        case .Time:
            self.isHidden = false
            self.timeLabel.text = String(format: "%ld %@", duration, durationUnit)
        case .Text:
            self.isHidden = false
            self.timeLabel.text = skipTitle
        case .TimeText:
            self.isHidden = false
            self.timeLabel.text = String(format: "%ld %@", duration, skipTitle)
        case .RoundTime:
            self.isHidden = false
            self.timeLabel.text = String(format: "%ld %@", duration, skipTitle)
        case .RoundText:
            self.isHidden = false
            self.timeLabel.text = skipTitle
        case .RoundProgressTime:
            self.isHidden = false
            self.timeLabel.text = String(format: "%ld %@", duration, skipTitle)
        case .RoundProgressText:
            self.isHidden = false
            self.timeLabel.text = skipTitle
        }
    }
    
    public func startRoundDispathTimerWith(duration: CGFloat) {
        let period: TimeInterval = 0.05
        var roundDuration: CGFloat = duration; //倒计时时间
        self.roundTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        self.roundTimer!.schedule(deadline: .now(), repeating: .milliseconds(1000))
        self.roundTimer!.setEventHandler {
            DispatchQueue.main.async {
                if(roundDuration<=0) {
                    self.roundLayer.strokeStart = 1
                    self.stopTimer()
                }
                var strokeStart: CGFloat = self.roundLayer.strokeStart
                strokeStart = strokeStart + 1/(duration/CGFloat(period))
                self.roundLayer.strokeStart += strokeStart
                roundDuration -= CGFloat(period)
            }
        }
        self.roundTimer!.resume()
    }
    
    func stopTimer() -> Void {
        self.roundTimer?.cancel()
        self.roundTimer = nil
    }
    
    fileprivate func cornerRadiusWithView(_ view: UIView) {
        var min: CGFloat = view.frame.size.height
        if view.frame.size.height > view.frame.size.width {
            min = view.frame.size.width
        }
        view.layer.cornerRadius = min/2.0
        view.layer.masksToBounds = true
    }
    
    // MARK Lazy load
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel.init(frame: self.bounds)
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        timeLabel.layer.masksToBounds = true
        timeLabel.textAlignment = .center
        timeLabel.font = kArialFont(13.5)
        self.cornerRadiusWithView(timeLabel)
        return timeLabel
    } ()
    
    lazy var roundLayer: CAShapeLayer = {
        let roundLayer = CAShapeLayer.init()
        roundLayer.fillColor = UIColor.black.withAlphaComponent(0.4).cgColor
        roundLayer.strokeColor = UIColor.white.cgColor
        roundLayer.lineCap = .round
        roundLayer.lineJoin = .round
        roundLayer.lineWidth = 2
        roundLayer.frame = self.bounds
        roundLayer.path = UIBezierPath.init(arcCenter: CGPoint(x: self.timeLabel.bounds.size.width/2.0, y: self.timeLabel.bounds.size.width/2.0), radius: self.timeLabel.bounds.size.width/2.0-1.0, startAngle:CGFloat(-0.5 * .pi), endAngle:CGFloat(1.5 * .pi), clockwise: true).cgPath
        roundLayer.strokeStart = 0
        return roundLayer
    }()
}

