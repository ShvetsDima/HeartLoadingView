//
//  ViewController.swift
//  HeartLoadingView
//
//  Created by Dima Shvets on 02/25/2018.
//  Copyright (c) 2018 Dima Shvets. All rights reserved.
//

import UIKit
import HeartLoadingView

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingView: HeartLoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getRandomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
}

extension ViewController {
    
    @IBAction func didChangeProgress(_ sender: UISlider) {
        loadingView.progress = Double(sender.value)
    }
    
    @IBAction func didChangeAmplitude(_ sender: UISlider) {
        loadingView.heartAmplitude = Double(sender.value)
    }
    
    @IBAction func didShowProgressText(_ sender: UISwitch) {
        loadingView.isShowProgressText = sender.isOn
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        let randomColor = self.getRandomColor()
        loadingView.heavyHeartColor = randomColor
        loadingView.lightHeartColor = randomColor.withAlphaComponent(0.5)
        loadingView.fillHeartColor = randomColor.withAlphaComponent(0.2)
        
    }

}

