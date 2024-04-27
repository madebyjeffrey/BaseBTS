//
//  ComponentTests.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation

import XCTest
@testable import BaseBTS

final class ComponentTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTwoComponents() {
        let c1 = TestComponent(name: "Hello")
        let c2 = SecondTestComponent()
        
        print("TestComponent id \(c1.identifier.id)")
        
        XCTAssertNotEqual(c1.identifier, c2.identifier)
    }
    
    func testOneComponentEquality() {
        let c1 = TestComponent(name: "Hello")
        let c2 = TestComponent(name: "Hello")
        
        XCTAssertEqual(c1, c2)
    }
    
    func testOneComponentNotEqual() {
        let c1 = TestComponent(name: "H1")
        let c2 = TestComponent(name: "H2")
        
        XCTAssertNotEqual(c1, c2)
    }
}
