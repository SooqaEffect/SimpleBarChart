//
//  BarCharLineTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class BarCharLineTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testInitBarCharLine() {
        let chartLine = BarChartLine(width: 20, color: UIColor.green.cgColor, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 0), value: 30)
        
        XCTAssertNotNil(chartLine)
        XCTAssertEqual(chartLine.value, 30)
    }

}
