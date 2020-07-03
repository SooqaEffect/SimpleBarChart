//
//  BarValueData.swift
//  BasicBarChart
//
//  Created by Вячеслав Яшунин on 29.06.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import UIKit

public struct BarValueData {
    ///Высота столбца
    public var height: Float!
    ///Нижнее обозначение столбца
    public let title: String
    ///Цвет столбца
    public let color: UIColor
    ///Цвет обозначения столбца
    public let titleColor: UIColor
    ///Значение столбца
    public let value: Int
    
    
    public init(title: String, color: UIColor, titleColor: UIColor, value: Int) {
        self.title = title
        self.color = color
        self.titleColor = titleColor
        self.value = value
    }
}
