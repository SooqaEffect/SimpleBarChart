//
//  SeconViewControllerTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class SeconViewControllerTests: XCTestCase {

    var sut: SecondViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: SecondViewController.self)) as? SecondViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
    }
    
    func testSutNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testPresenterNotNil() {
        XCTAssertNotNil(sut.presenter)
    }
    
    func testViewControllerHasChartView() {
        XCTAssertTrue(sut.chartView.isDescendant(of: sut.view))
    }
    
    
    func testSuccessMethod() {
        let data = [BarValueData(title: "Foo", color: .black, titleColor: .green, value: 30)]
        sut.onSuccess(data: data)
        
        XCTAssertEqual(sut.chartView.barData.first?.data.title, data.first?.title)
    }
    
    func testSetsEmptyDataToChart() {
        sut.viewWillAppear(true)
        XCTAssertTrue(sut.chartView.barData.first?.data.value == 0)
    }
    

}
