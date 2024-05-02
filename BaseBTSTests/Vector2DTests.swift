//
//  Vector2DTests.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-25.
//

import Foundation

import XCTest
@testable import BaseBTS

final class Vector2DTests: XCTestCase {
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testZero() {
        let z = Vector2D.zero()
        
        XCTAssertTrue(z.x.isAlmostZero())
        XCTAssertTrue(z.y.isAlmostZero())
    }
    
    func testMagnitude() {
        // values carefully chosen to become sqrt 10
        let v = Vector2D(x: 8, y: 6)
        
        let mag = v.magnitude()
        
        XCTAssertTrue(mag.isAlmostEqual(to: 10.0))
        
    }
    
    func testNormalize() {
        let v = Vector2D(x: 8, y: 6)
        
        let n = v.normalize()
        
        XCTAssertTrue(n.x.isAlmostEqual(to: 0.8))
        XCTAssertTrue(n.y.isAlmostEqual(to: 0.6))
    }
    
    func testDistance() {
        let v1 = Vector2D(x: 10, y: 0)
        let v2 = Vector2D(x: 30, y: 0)
        
        let d = v1.distance(to: v2)
        
        XCTAssertTrue(d.isAlmostEqual(to: 20.0))
    }
    
    func testSubtract() {
        let v1 = Vector2D(x: 10, y: 50)
        let v2 = Vector2D(x: 30, y: 20)
        
        let s = v2.subtract(from: v1)
        
        XCTAssertTrue(s.x.isAlmostEqual(to: -20.0))
        XCTAssertTrue(s.y.isAlmostEqual(to: 30.0))
    }
    
    func testMultiply() {
        let v1 = Vector2D(x: 10, y: 50)
        
        let s = v1.multiply(by: 5.0)
        
        XCTAssertTrue(s.x.isAlmostEqual(to: 50.0))
        XCTAssertTrue(s.y.isAlmostEqual(to: 250.0))
    }
    
    func testDivide() {
        let v1 = Vector2D(x: 10, y: 50)
        
        let s = v1.divide(by: 5.0)
        
        XCTAssertTrue(s.x.isAlmostEqual(to: 2.0))
        XCTAssertTrue(s.y.isAlmostEqual(to: 10.0))
    }
}
