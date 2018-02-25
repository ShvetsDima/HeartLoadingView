//
//  HeartLoadingView.swift
//  HeartLoadingView
//
//  Created by Dima Shvets on 25.02.2018.
//

import UIKit

class HeartLoadingView: UIView {
    
    var originX = 0.0
    static private let amplitude_min = 16.0
    static private let amplitude_span = 26.0
    
    private let cycle = 1.0
    private var term = 60.0
    private var phasePosition = 0.0
    private var amplitude = 29.0
    private var position = 40.0
    
    private let waveMoveSpan = 5.0
    private let animationUnitTime = 0.08
    
    private let heavyColor = UIColor(red: 254/255.0, green: 102/255.0, blue: 131/255.0, alpha: 1.0)
    private let lightColor = UIColor(red: 254/255.0, green: 168/255.0, blue: 194/255.0, alpha: 1.0)
    
    private let clipCircleColor = UIColor.gray
    private let fillCircleColor = UIColor(red: 248/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
    
    private var clipCircleLineWidth: CGFloat = 1
    
    private let progressTextFontSize: CGFloat = 15.0
    
    private var waving: Bool = true
    
    class var amplitudeMin: Double {
        get { return amplitude_min }
    }
    class var amplitudeSpan: Double {
        get { return amplitude_span }
    }
    
    var progress: Double = 0.5 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var waveAmplitude: Double {
        get { return amplitude }
        set {
            amplitude = newValue
            self.setNeedsDisplay()
        }
    }
    
    var borderWidth: CGFloat {
        get { return clipCircleLineWidth }
        set {
            clipCircleLineWidth = newValue
            self.setNeedsDisplay()
        }
    }
    
    var isShowProgressText = true
    
    override func awakeFromNib() {
        animationWave()
        self.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        animationWave()
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit { }
    
    override func draw(_ rect: CGRect) {
        position =  (1 - progress) * Double(rect.height)
        
        clipWithCircle()
        
        drawWaveWater(originX: originX - term / 5, fillColor: lightColor)
        drawWaveWater(originX: originX, fillColor: heavyColor)
        
        if isShowProgressText {
            drawProgressText()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        term =  Double(self.bounds.size.width) / cycle
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        waving = false
    }
    
    func clipWithCircle() {
        let circleRectWidth = min(self.bounds.size.width, self.bounds.size.height) - 2 * clipCircleLineWidth
        let circleRectOriginX = (self.bounds.size.width - circleRectWidth) / 2
        let circleRectOriginY = (self.bounds.size.height - circleRectWidth) / 2
        let circleRect = CGRect(x: circleRectOriginX, y: circleRectOriginY,
                                width: circleRectWidth, height: circleRectWidth)
        
        //let clipPath = UIBezierPath(heartIn: circleRect)
        
        fillCircleColor.setFill()
        clipPath.fill()
        clipPath.addClip()
    }
    
    
    func drawWaveWater(originX: Double, fillColor: UIColor) {
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
        
        var attribute: [NSAttributedStringKey : Any]!
        if progress > 0.45 {
            attribute = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: progressTextFontSize),
                         NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : UIColor.white]
        } else {
            attribute = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: progressTextFontSize),
                         NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : heavyColor]
        }
        
        let textSize = progressText.size(withAttributes: attribute)
        let textRect = CGRect(x: self.bounds.width/2 - textSize.width/2,
                              y: self.bounds.height/2 - textSize.height/2, width:textSize.width, height:textSize.height)
        
        progressText.draw(in: textRect, withAttributes: attribute)
    }
    
    
    func animationWave() {
        DispatchQueue.global(qos: .default).async { [weak self]() -> Void in
            if self != nil {
                let tempOriginX = self!.originX
                while self != nil && self!.waving {
                    if self!.originX <= tempOriginX - self!.term {
                        self!.originX = tempOriginX - self!.waveMoveSpan
                    } else {
                        self!.originX -= self!.waveMoveSpan
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
