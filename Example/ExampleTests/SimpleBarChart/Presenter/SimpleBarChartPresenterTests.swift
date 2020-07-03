//
//  SimpleBarChartPresenterTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class SimpleBarChartPresenterTests: XCTestCase {
    
    
    var sut: SimpleBarChartPresenterProtocol!
    let view = SimpleBarChartView()
    override func setUpWithError() throws {
        let configuration = BarChartConfiguration(animated: true, barWidth: 20, spacing: 20, isScrollEnabled: true)
        let barData = [BarValueData(title: "Foo", color: .black, titleColor: .white, value: 20)]
        
        sut = SimpleBarChartPresenter(view: view, barWidth: configuration.barWidth, spacing: configuration.spacing, barData: barData)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testPresenterInited() {
        XCTAssertNotNil(sut)
    }
    
    func testViewNotNil() {
        XCTAssertNotNil(sut.view)
    }
    
    func testBarDataSets() {
        XCTAssertEqual(sut.barValueData.first!.title, "Foo")
    }
    
    func testWidthSets() {
        XCTAssertEqual(sut.barWidth, 20)
    }
    
    func testHeightIsCalculated() {
        sut.calculateHeight()
        XCTAssertNotNil(sut.barValueData.first!.height)
    }
    
    func testSetBarDataCreateCorrectData() {
        sut.calculateHeight()
        let data = sut.setBarData(maxHeight: 30)
        
        XCTAssertEqual(sut.barValueData.first?.title, data.first?.data.title)
    }
    
    func testGetHorizontalLines() {
        sut.calculateHeight()
        let charts = sut.getHorizontalLinesToChart(maxHeight: 30)
        
        XCTAssertTrue(charts.first?.width == 0.5)
    }
}
