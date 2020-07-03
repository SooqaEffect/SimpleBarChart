//
//  ArrayExtensionsTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example


class ArrayExtensionsTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    func testSafeArrayMethod() {
        let someArray = [1,2,3,4]
        
        XCTAssertNotNil(someArray.safeValue(at: 2))
        XCTAssertNil(someArray.safeValue(at: 10))
    }

}
