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
  var fillView : UIView = UIView()
  let scoreLabel: UILabel = UILabel()
  
  init(frame: CGRect, title: String, maxValue : Int){
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func addData(tag: Int, min: Double, max: Double){
    var titleText : String = ""
    self.min = min
    self.max = max
    var maskColor : UIColor = .clear
    switch tag{
    case 0:
      titleText = "Activity Level"
      maskColor = UIColor.niceGreen
    case 1:
      titleText = "Self Harm"
      maskColor = UIColor.niceRed
    case 2:
      titleText = "Stress"
      maskColor = UIColor.niceBlue
    default:
      print("Yikes, yell at Alex for not mathing right")
    }
    
    
    let label = UILabel(frame: CGRect(x: 13.0, y: 0.0, width: 100.0, height: 20.0))
    label.text = titleText
    label.font = label.font.withSize(15)
    label.minimumScaleFactor = 0.5
    label.textColor = UIColor.steelBlue
    self.addSubview(label)
    
    scoreLabel.frame = CGRect(x: self.bounds.width - 23 - 52, y: 0, width: 52.0, height: 18)
    print(scoreLabel.frame)
    scoreLabel.text = "\(Int(min)) of \(Int(max))"
    scoreLabel.font = label.font.withSize(15)
    scoreLabel.minimumScaleFactor = 0.5
    scoreLabel.lineBreakMode = .byClipping
    scoreLabel.textColor = UIColor.steelBlue
    self.addSubview(scoreLabel)
    
    let fullTubeView = UIView(frame: CGRect(x: 13, y: 22.0, width: self.bounds.width-26.0, height: 39.0))
    fullTubeView.backgroundColor = UIColor.niceGray
    fullTubeView.layer.cornerRadius = 39.0 / 2.0
    
    self.addSubview(fullTubeView)
    
    fillView.backgroundColor = maskColor
    fillView.frame = CGRect(x: 0, y: 0, width: 0, height: 39.0)
    fillView.layer.cornerRadius = 39.0 / 2.0
    
    fullTubeView.addSubview(fillView)
    
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      print("Location: \(location)")
      percentage = Double(location.x) / Double(fillView.superview!.frame.width) * 100.0
      setView(x : location.x, y: location.y)
      
    }
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      print("Location: \(location)")
      percentage = Double(location.x) / Double(fillView.superview!.frame.width) * 100.0
      setView(x : location.x, y: location.y)
    }
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      print("Location: \(location)")
      percentage = Double(location.x) / Double(fillView.superview!.frame.width) * 100.0
      
      setView(x : location.x, y: location.y)
    }
  }
  
  func getCurrentValue() -> Double{
    let range: Double = max - min
    let relativeValue = range * percentage / 100.0
    let result : Double = min + relativeValue
    return result
  }
  
  func setView(x : CGFloat, y: CGFloat){
  
    scoreLabel.text = "\(Int(getCurrentValue())) of \(Int(max))"
    var width = x - 13
    if width < 0{
      width = 0
    }
    else if width > fillView.superview!.frame.width{
      width = fillView.superview!.frame.width
    }
    
    fillView.frame = CGRect(x: 0, y: 0, width: width, height: 39.0)
  }
  

}
