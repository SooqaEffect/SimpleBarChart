//
//  ArrayExtensions.swift
//  BasicBarChart
//
//  Created by Вячеслав Яшунин on 30.06.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
extension Array {
    func safeValue(at index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
