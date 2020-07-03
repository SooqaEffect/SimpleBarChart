//
//  BasicBarChartPresenter.swift
//  BasicBarChart
//
//  Created by Вячеслав Яшунин on 30.06.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics.CGGeometry

protocol SimpleBarChartPresenterProtocol: class {
    var view: SimpleBarChartViewProtocol! { get set }
    var barWidth: CGFloat! { get }
    var spacing: CGFloat! { get }
    var barValueData: [BarValueData]! { get }
    
    init(view: SimpleBarChartViewProtocol, barWidth: CGFloat, spacing: CGFloat, barData: [BarValueData])
    
    func getContentWidth() -> CGFloat
    func calculateHeight()
    func getHorizontalLinesToChart(maxHeight: CGFloat) -> [BarChartLine]
    func setBarData(maxHeight: CGFloat) -> [BarData]
}

class SimpleBarChartPresenter: SimpleBarChartPresenterProtocol {
    
    unowned var view: SimpleBarChartViewProtocol!
    
    private(set) var barWidth: CGFloat!
    private(set) var spacing: CGFloat!
    private(set) var barValueData: [BarValueData]!
    
    ///Расстояние для показа столбца названия
    private let bottomSpace: CGFloat = 40.0
    
    /// Расстояние для показа значения столбца
    private let topSpace: CGFloat = 40.0
    
    required init(view: SimpleBarChartViewProtocol, barWidth: CGFloat, spacing: CGFloat, barData: [BarValueData]) {
        self.view = view
        self.barWidth = barWidth
        self.spacing = spacing
        self.barValueData = barData
    }
    
    
    func getContentWidth() -> CGFloat {
        return (barWidth + spacing) * CGFloat(barValueData.count) + spacing
    }
    
    func calculateHeight() {
        let maxObject = barValueData.max(by: {$0.value < $1.value})!
        
        var isNotEmpty = false
        
        for i in self.barValueData {
            if i.value != 0 {
                isNotEmpty = true
            }
        }
        
        if isNotEmpty {
            for i in 0..<self.barValueData.count {
                var object = self.barValueData[i]
                
                if object.value == maxObject.value {
                    object.height = 1.0
                } else {
                    let objectValue = Float(object.value * 100)
                    let maxValue = Float(maxObject.value)
                    
                    let percent = Float(objectValue / maxValue)
                    let height = Float(percent / 100)
                    object.height = Float(height)
                }
                self.barValueData[i] = object
            }
        } else {
            for i in 0..<self.barValueData.count {
                var object = self.barValueData[i]
                object.height = 0.0
                self.barValueData[i] = object
            }
        }
        
        
    }
    
    
    func setBarData(maxHeight: CGFloat) -> [BarData] {
        var barEntries = [BarData]()
        
        for (index, entry) in self.barValueData.enumerated() {
            let entryHeight: CGFloat = CGFloat(entry.height) * (maxHeight - bottomSpace - topSpace)
            let xPosition: CGFloat = spacing + CGFloat(index) * (barWidth + spacing)
            let yPosition: CGFloat = maxHeight - bottomSpace - entryHeight
            
            let originPosition = CGPoint(x: xPosition, y: yPosition)
            
            let barEntry = BarData(origin: originPosition, barWidth: self.barWidth, barHeight: entryHeight, spacing: self.spacing, data: entry)
            
            barEntries.append(barEntry)
            
        }
        
        return barEntries
    }
    
    
    func getHorizontalLinesToChart(maxHeight: CGFloat) -> [BarChartLine] {
        var lines = [BarChartLine]()
        
        let maxObject = self.barValueData.max(by: {$0.value < $1.value})!
        
        let middleHeight = (maxObject.height + 0) / 2
        let middleValue = (maxObject.value + 0) / 2
        
        let linesInfo = [
            (position: 0.0, value: 0),
            (position: CGFloat(middleHeight), value: Int(middleValue)),
            (position: CGFloat(maxObject.height), value: Int(maxObject.value))
        ]
        
        for lineInfo in linesInfo {
            let yPosition = maxHeight - bottomSpace - lineInfo.position * (maxHeight - bottomSpace - topSpace)
            let lineLenght = self.getContentWidth()
            
            
            let startPosition = CGPoint(x: 0, y: yPosition)
            let endPosition = CGPoint(x: lineLenght, y: yPosition)
            
            let line = BarChartLine(width: 0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor, startPoint: startPosition, endPoint: endPosition, value: lineInfo.value)
            lines.append(line)
        }
        
        return lines
    }
}
