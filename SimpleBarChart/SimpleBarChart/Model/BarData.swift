//
//  BarData.swift
//  BasicBarChart
//
//  Created by Вячеслав Яшунин on 29.06.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

public struct BarData {
    let origin: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    let spacing: CGFloat
    let data: BarValueData
    
    var barFrame: CGRect {
        return CGRect(x: origin.x, y: origin.y, width: barWidth, height: barHeight)
    }
    
    var titleFrame: CGRect {
        return CGRect(x: origin.x - spacing / 2, y: origin.y + 10 + barHeight, width: barWidth + spacing, height: 22)
    }
}
