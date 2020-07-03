//
//  BarDataTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class BarDataTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testBarDataInit() {
        let barValueData = BarValueData(title: "Foo", color: .gray, titleColor: .black, value: 20)
        let origin = CGPoint(x: 0, y: 0)
        let barData = BarData(origin: origin, barWidth: 20, barHeight: 20, spacing: 20, data: barValueData)
        
        
        XCTAssertNotNil(barData)
    }
    
    func testBarDataHasBarFrame() {
        let barData = createData()
        XCTAssertEqual(barData.barFrame, CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    func testBarDataHasTitleFrame() {
        let barData = createData()
        let frame = CGRect(x: barData.origin.x - barData.spacing / 2, y: barData.origin.y + 10 + barData.barWidth, width: barData.barWidth + barData.spacing, height: 22)
        XCTAssertEqual(barData.titleFrame, frame)
    }
    
    private func createData() -> BarData {
        let barValueData = BarValueData(title: "Foo", color: .gray, titleColor: .black, value: 20)
        let origin = CGPoint(x: 0, y: 0)
        return BarData(origin: origin, barWidth: 20, barHeight: 20, spacing: 20, data: barValueData)
    }

}
