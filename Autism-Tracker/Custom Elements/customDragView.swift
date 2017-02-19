//
//  customDragView.swift
//  Autism-Tracker
//
//  Created by Alexander Dejeu on 2/18/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

class customDragView: UIView {
  
  var percentage: Double = 40
  var min: Double = 0
  var max: Double = 10
  
  init(frame: CGRect, title: String, maxValue : Int){
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
    super.init(coder: aDecoder)
  }
  
  func addCrappySlider(){
    var slider = UISlider(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
    slider.minimumValue = 0
    slider.maximumValue = 100
    slider.isContinuous = true
    slider.tintColor = .red
    slider.value = Float(percentage)
    slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
    print("yeah we made it")
    print(self.frame)
    self.addSubview(slider)
  }

  func sliderValueDidChange(sender:UISlider!){
    print("value--\(sender.value)")
    percentage = Double(sender.value)
  }
  
  func getCurrentValue() -> Double{
    let range: Double = max - min
    let relativeValue = range * percentage / 100.0
    let result : Double = min + relativeValue
    return result
  }
}
