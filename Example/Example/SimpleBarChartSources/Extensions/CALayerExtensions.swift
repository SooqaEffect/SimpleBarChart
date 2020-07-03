//
//  CALayerExtensions.swift
//  Example
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    func animate(fromValue: Any, toValue: Any, keyPath: String) {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.add(animation, forKey: keyPath)
    }
    
    func addRectangle(frame: CGRect, color: CGColor, animated: Bool, previousFrame: CGRect?) {
        let layer = CALayer()
        
        layer.frame = frame
        layer.backgroundColor = color
        
        self.addSublayer(layer)
        
        if animated, let previousFrame = previousFrame {
            layer.animate(fromValue: CGPoint(x: previousFrame.midX, y: previousFrame.midY), toValue: layer.position, keyPath: "position")
            layer.animate(fromValue: CGRect(x: 0, y: 0, width: previousFrame.width, height: previousFrame.height), toValue: layer.bounds, keyPath: "bounds")
        }
    }
    
    func addLine(startPoint: CGPoint, endPoint: CGPoint, color: CGColor, width: CGFloat, animated: Bool) {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color
        self.addSublayer(layer)
        
        
        //add animation
    }
    
    func addText(frame: CGRect, color: CGColor, fontSize: CGFloat, text: String, animated: Bool, ailgnmentMode: CATextLayerAlignmentMode) {
        let textLayer = CATextLayer()
        textLayer.frame = frame
        textLayer.foregroundColor = color
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = ailgnmentMode
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = fontSize
        textLayer.string = text
        
        self.addSublayer(textLayer)
        //add animation
    }
}
