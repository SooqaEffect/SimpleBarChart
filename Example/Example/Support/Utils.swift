//
//  Utils.swift
//  Example
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation

class Utils {
    static var emptyDataCount = 0
    
    static func setEmptyData() -> [BarValueData] {
        var result: [BarValueData] = []
        Array(0..<emptyDataCount).forEach {_ in
            result.append(BarValueData(title: "", color: .clear, titleColor: .clear, value: 0))
        }
        return result
    }
}
