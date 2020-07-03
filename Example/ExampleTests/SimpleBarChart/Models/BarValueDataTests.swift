//
//  BarValueDataTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class BarValueDataTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testBarValueDataInit() {
        let barValueData = BarValueData(title: "Foo", color: .gray, titleColor: .black, value: 20)
        
        XCTAssertNotNil(barValueData)
        XCTAssertEqual(barValueData.title, "Foo")
    }
}
