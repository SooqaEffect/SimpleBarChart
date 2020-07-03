//
//  SecondPresenterTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class SecondPresenterTests: XCTestCase {

    let mockView = MockSecondView()
    var sut: MockSecondViewPresenter!
    
    override func setUpWithError() throws {
        sut = MockSecondViewPresenter(with: mockView)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetDaysWeekNotEmpty() {
        let days = sut.getDaysInWeek()
        
        XCTAssertTrue(!days.isEmpty)
        XCTAssertEqual(days.count, 7)
    }
    
    func testGetData() {
        sut.getDataFromLastWeak()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.sut.days)
            XCTAssertTrue(!self.sut.days.isEmpty)
        }
    }
}

extension SecondPresenterTests {
    class MockSecondViewPresenter: SecondViewPresenter {
        
        var totalStepsIsRun = false

        override func getTotalSteps(with startDate: Date, completion: @escaping (Double) -> Void) {
            self.totalStepsIsRun = true
            super.getTotalSteps(with: startDate, completion: completion)
        }
        
    }
    
    class MockSecondView: SecondViewController {
        
        
    }
}
