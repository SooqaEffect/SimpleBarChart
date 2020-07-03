//
//  BarChartConfigurationTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class BarChartConfigurationTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testChartConfigurationInit() {
        let config = BarChartConfiguration(animated: true, barWidth: 20, spacing: 20, isScrollEnabled: false)
        
        XCTAssertNotNil(config)
        XCTAssertEqual(config.isScrollEnabled, false)
    }

}
