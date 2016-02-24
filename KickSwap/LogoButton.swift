//
//  LogoButton.swift
//  KickSwap
//
//  Created by Gonzalo Nunez on 7/22/15.
//  Copyright (c) 2015 Gonzalo Nunez. All rights reserved.
//

import Foundation
import UIKit

enum LogoButtonStyle {
  case Default, IconOnly
}

@IBDesignable class LogoButton: UIButton {
  
  @IBInspectable var buttonStyle:LogoButtonStyle = .Default {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var logo:UIImage?
  
  @IBInspectable var trueBackgroundColor:UIColor = UIColor.redColor() {
    didSet {
      setNeedsDisplay()
    }
  }
  
  static let kMinLogoWidth: CGFloat = 20
  
  var padding:CGFloat = 8 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  var isPressed = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUp()
  }
  
  private func setUp() {
    adjustsImageWhenHighlighted = false
    contentHorizontalAlignment = .Left
    contentVerticalAlignment = .Center
    addTargets()
  }
  
  private func addTargets() {
    addTarget(self, action: Selector("touchedDown:"), forControlEvents: .TouchDown)
    addTarget(self, action: Selector("touchedUpInside:"), forControlEvents: .TouchUpInside)
    addTarget(self, action: Selector("touchDraggedOutside:"), forControlEvents: .TouchDragOutside)
  }
  
  @objc private func touchedDown(button: LogoButton) {
    isPressed = true
  }
  
  @objc private func touchedUpInside(button: LogoButton) {
    isPressed = false
  }
  
  @objc private func touchDraggedOutside(button: LogoButton) {
    isPressed = false
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    layer.shadowOpacity = 0.6
    layer.shadowColor = UIColor.darkGrayColor().CGColor
    layer.shadowRadius = 1.5
    layer.shadowOffset = CGSize(width: 0, height: 1)
    
    layer.cornerRadius = 4
    
    guard let context = UIGraphicsGetCurrentContext() else { return }
    CGContextSaveGState(context)
    
    let minx = bounds.minX
    let midx = bounds.midX
    let maxx = bounds.maxX
    
    let miny = bounds.minY
    let midy = bounds.midY
    let maxy = bounds.maxY
    
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, layer.cornerRadius)
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, layer.cornerRadius)
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, layer.cornerRadius)
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, layer.cornerRadius)
    
    CGContextClosePath(context)
    
    var color = trueBackgroundColor
    
    if (isPressed) {
      var h:CGFloat = 0,
          s:CGFloat = 0,
          b:CGFloat = 0,
          a:CGFloat = 0
      
      color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
      color = UIColor(hue: h, saturation: s, brightness: b * 0.9, alpha: a)
    }
    
    color.setFill()
    UIColor.clearColor().setStroke()
    
    CGContextDrawPath(context, .Fill)
    
    CGContextRestoreGState(context)
    
    guard let logo = logo else { return }
    
    let isIconOnly = (buttonStyle == .IconOnly)
    
    let maxHeight = maxImageHeightForRect(rect)
    let maxWidth = logo.size.width * (maxHeight/logo.size.height)
    
    let desiredImageSize = CGSize(width: maxWidth, height: maxHeight)
    
    let originX = isIconOnly ? (rect.width - desiredImageSize.width)/2 : padding
    let originY = isIconOnly ? (rect.height - desiredImageSize.height)/2 : rect.midY - desiredImageSize.height/2
    
    let desiredRect = CGRect(origin: CGPoint(x: originX, y: originY), size: desiredImageSize)
    logo.drawInRect(desiredRect)
    
    titleLabel?.alpha = isIconOnly ? 0 : 1
    
    //let left = padding + minWidth
    //let imageTitlePadding:CGFloat = 22
    titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        
  }
  
  private func maxImageHeightForRect(rect:CGRect) -> CGFloat {
    return min(LogoButton.kMinLogoWidth, min(rect.width - padding, rect.height - padding))
  }
  
}