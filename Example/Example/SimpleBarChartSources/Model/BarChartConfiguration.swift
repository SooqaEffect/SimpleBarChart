//
//  BarChartConfiguration.swift
//  BasicBarChart
//
//  Created by Вячеслав Яшунин on 30.06.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry

public struct BarChartConfiguration {
    ///Отвечает за анимацию при использовании метода setData
    public let animated: Bool
    ///Ширина столбца в графике
    public let barWidth: CGFloat
    ///Расстояние между столбцами
    public let spacing: CGFloat
    ///Параметр, отвечающий за разрешение скролла, если контент не вмещается в ширину экрана
    public let isScrollEnabled: Bool
    
    
    public init(animated: Bool, barWidth: CGFloat, spacing: CGFloat, isScrollEnabled: Bool) {
        self.animated = animated
        self.barWidth = barWidth
        self.spacing = spacing
        self.isScrollEnabled = isScrollEnabled
    }
}
