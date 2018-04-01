//
//  HeartLoadingView.swift
//  HeartLoadingView
//
//  Created by Dima Shvets on 25.02.2018.
//

import UIKit

public class HeartLoadingView: UIView {
    
    private var originX = 0.0
    private let cycle = 1.0
    private var term = 60.0
    private var phasePosition = 0.0
    private var amplitude = 29.0
    private var position = 40.0
    private let animationMoveSpan = 5.0
    private let animationUnitTime = 0.08
    
    public var heavyHeartColor = UIColor(red: 254/255.0, green: 102/255.0, blue: 131/255.0, alpha: 1.0)
    public var lightHeartColor = UIColor(red: 254/255.0, green: 168/255.0, blue: 194/255.0, alpha: 1.0)
    public var fillHeartColor = UIColor(red: 248/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
    
    public let progressTextFont: UIFont = UIFont.systemFont(ofSize: 15.0)
    public var isShowProgressText = true
    
    public var isAnimated: Bool = true
    
    public var progress: Double = 0.5 {
        didSet { self.setNeedsDisplay() }
    }
    
    public var heartAmplitude: Double {
        get { return amplitude }
        set {
            amplitude = newValue
            self.setNeedsDisplay()
        }
    }
    
    override public func awakeFromNib() {
        animationHeart()
        self.backgroundColor = UIColor.clear
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        animationHeart()
        self.backgroundColor = UIColor.clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override public func draw(_ rect: CGRect) {
        position =  (1 - progress) * Double(rect.height)
        
        clipWithHeart()
        
        drawHeartWave(originX: originX - term / 5, fillColor: lightHeartColor)
        drawHeartWave(originX: originX, fillColor: heavyHeartColor)
        
        if isShowProgressText {
            drawProgressText()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        term =  Double(self.bounds.size.width) / cycle
    }
    
    override public func removeFromSuperview() {
        super.removeFromSuperview()
        isAnimated = false
    }
    
    func clipWithHeart() {
        let heartRectWidth = min(self.bounds.size.width, self.bounds.size.height)
        let heartRectOriginX = (self.bounds.size.width - heartRectWidth) / 2
        let heartRectOriginY = (self.bounds.size.height - heartRectWidth) / 2
        let heartRect = CGRect(x: heartRectOriginX, y: heartRectOriginY, width: heartRectWidth, height: heartRectWidth)
        
        let clipPath = UIBezierPath(heartIn: heartRect)
        
        fillHeartColor.setFill()
        clipPath.fill()
        clipPath.addClip()
    }
    
    
    func drawHeartWave(originX: Double, fillColor: UIColor) {
        let curvePath = UIBezierPath()
        curvePath.move(to: CGPoint(x: originX, y: position))
        
        var tempPoint = originX
        for _ in 1...rounding(value: 4 * cycle) {
            curvePath.addQuadCurve(to: keyPoint(x: tempPoint + term / 2, originX: originX),
                                   controlPoint: keyPoint(x: tempPoint + term / 4, originX: originX))
            tempPoint += term / 2
        }
        
        curvePath.addLine(to: CGPoint(x: curvePath.currentPoint.x, y: self.bounds.size.height))
        curvePath.addLine(to: CGPoint(x: CGFloat(originX), y: self.bounds.size.height))
        curvePath.close()
        
        fillColor.setFill()
        curvePath.lineWidth = 10
        curvePath.fill()
    }
    
    
    func drawProgressText() {
        var validProgress = progress * 100
        validProgress = validProgress < 1 ? 0 : validProgress
        
        let progressText = (NSString(format: "%.0f", validProgress) as String) + "%"
        
        var attributes: [NSAttributedStringKey : Any] = [.font: progressTextFont]
        if progress > 0.45 {
            attributes.updateValue(UIColor.white, forKey: .foregroundColor)
        } else {
            attributes.updateValue(heavyHeartColor, forKey: .foregroundColor)
        }
        
        let textSize = progressText.size(withAttributes: attributes)
        let textRect = CGRect(x: self.bounds.width/2 - textSize.width/2,
                              y: self.bounds.height/2 - textSize.height/2, width:textSize.width, height:textSize.height)
        
        progressText.draw(in: textRect, withAttributes: attributes)
    }
    
    
    func animationHeart() {
        DispatchQueue.global(qos: .default).async { [weak self]() -> Void in
            if self != nil {
                let tempOriginX = self!.originX
                while self != nil && self!.isAnimated {
                    if self!.originX <= tempOriginX - self!.term {
                        self!.originX = tempOriginX - self!.animationMoveSpan
                    } else {
                        self!.originX -= self!.animationMoveSpan
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        self!.setNeedsDisplay()
                    })
                    Thread.sleep(forTimeInterval: self!.animationUnitTime)
                }
            }
        }
    }
    
    
    func keyPoint(x: Double, originX: Double) -> CGPoint {
        return CGPoint(x: x, y: columnYPoint(x: x - originX))
    }
    
    func columnYPoint(x: Double) -> Double {
        let result = amplitude * sin((2 * Double.pi / term) * x + phasePosition)
        return result + position
    }
    
    func rounding(value: Double) -> Int {
        let tempInt = Int(value)
        let tempDouble = Double(tempInt) + 0.5
        if value > tempDouble {
            return tempInt + 1
        } else {
            return tempInt
        }
    }
}
