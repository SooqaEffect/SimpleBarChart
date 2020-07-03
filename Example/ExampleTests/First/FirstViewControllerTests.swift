//
//  FirstViewControllerTests.swift
//  ExampleTests
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import XCTest
@testable import Example

class FirstViewControllerTests: XCTestCase {
    
    
    var sut: ViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testViewControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    
    func testViewControllerHasCharView() {
        XCTAssertTrue(sut.chartView.isDescendant(of: sut.view))
    }
    

}
