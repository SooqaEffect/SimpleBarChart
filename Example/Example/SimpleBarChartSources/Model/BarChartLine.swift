//
//  BarChartLine.swift
//  BasicBarChart
//
//  Created by Вячеслав Яшунин on 30.06.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

struct BarChartLine {
    let width: CGFloat
    let color: CGColor
    let startPoint: CGPoint
    let endPoint: CGPoint
    
    ///Значение для линии
    let value: Int
}
