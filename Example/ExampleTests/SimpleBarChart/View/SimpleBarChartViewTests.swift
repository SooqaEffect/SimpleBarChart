//
//  SimpleBarChartViewTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class SimpleBarChartViewTests: XCTestCase {

    var sut: SimpleBarChartView!
    
    override func setUpWithError() throws {
        sut = SimpleBarChartView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSutInit() {
        XCTAssertNotNil(sut)
    }
    
    func testBarChartHasScrollView() {
        XCTAssertTrue(sut.scrollView.isDescendant(of: sut))
    }
    
    func testBarChartHasMainLayer() {
        XCTAssertTrue(sut.scrollView.layer.superlayer != nil)
    }
    
    private func setData() {
        let configuration = BarChartConfiguration(animated: true, barWidth: 20, spacing: 20, isScrollEnabled: false)
        
        let data = [BarValueData(title: "Foo", color: .black, titleColor: .black, value: 100)]
        sut.setData(with: configuration, barData: data)
    }
    
    
    func testConfgigurationSetsToView() {
        setData()
        XCTAssertNotNil(sut.configuration)
    }
    
    func testConfigurationSetsCorrectly() {
        setData()
        XCTAssertEqual(sut.scrollView.isScrollEnabled, false)
    }
    
    func testBarDataSetsWhenUseSetDataMethod() {
        setData()
        XCTAssertNotNil(sut.barData.count == 1)
    }
    
    func testBarChartHasBottomText() {
        setData()
        XCTAssertTrue(sut.mainLayer.sublayers!.contains(where: {$0 is CATextLayer}))
    }
    
    func testBarChartHasSomeSublayers() {
        setData()
        XCTAssertTrue(!sut.mainLayer.sublayers!.isEmpty)
    }
    
    func testSubviewHasUILabels() {
        setData()
        XCTAssertTrue(sut.subviews.contains(where: {$0 is UILabel}))
    }
    
    func testScrollViewHasLines() {
        setData()
        setData()
        XCTAssertTrue(sut.mainLayer.sublayers!.contains(where: {$0 is CAShapeLayer}))
    }
}
