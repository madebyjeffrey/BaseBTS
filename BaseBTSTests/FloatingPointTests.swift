//
//  FloatingPointTests.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-27.
//

import Foundation

import XCTest
@testable import BaseBTS

final class FloatPointTests: XCTestCase {
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAlmostEqualFloat() {
        
        // Values for testing:
        var values = (Float.leastNonzeroMagnitude.exponent ...
                      Float.greatestFiniteMagnitude.exponent).flatMap {
            exp in [
                Float(sign: .plus, exponent: exp, significand: 1).nextDown,
                Float(sign: .plus, exponent: exp, significand: 1),
                Float(sign: .plus, exponent: exp, significand: 1).nextUp,
                Float(sign: .plus, exponent: exp, significand: .random(in: 1..<2))
            ]
        }
        values.append(.infinity)
        
        // Tolerances for testing:
        let tolerances = [
            2*Float.ulpOfOne, .random(in: .ulpOfOne..<1), Float(1).nextDown
        ]
        
        // NaN is not almost equal to anything, with any tolerance.
        XCTAssertFalse(Float.nan.isAlmostEqual(to: .nan))
        for tol in tolerances {
            XCTAssertFalse(Float.nan.isAlmostEqual(to: .nan, tolerance: tol))
        }
        for val in values {
            XCTAssertFalse(Float.nan.isAlmostEqual(to: val))
            XCTAssertFalse(val.isAlmostEqual(to: .nan))
            for tol in tolerances {
                XCTAssertFalse(Float.nan.isAlmostEqual(to: val, tolerance: tol))
                XCTAssertFalse(val.isAlmostEqual(to: .nan, tolerance: tol))
            }
        }
        
        for val in values {
            XCTAssertTrue(val.isAlmostEqual(to: val))
            XCTAssertTrue(val.isAlmostEqual(to: val.nextUp))
            XCTAssertTrue(val.nextUp.isAlmostEqual(to: val))
            XCTAssertTrue(val.isAlmostEqual(to: val.nextDown))
            XCTAssertTrue(val.nextDown.isAlmostEqual(to: val))
            for tol in tolerances {
                XCTAssertTrue(val.isAlmostEqual(to: val, tolerance: tol))
                XCTAssertTrue(val.isAlmostEqual(to: val.nextUp, tolerance: tol))
                XCTAssertTrue(val.nextUp.isAlmostEqual(to: val, tolerance: tol))
                XCTAssertTrue(val.isAlmostEqual(to: val.nextDown, tolerance: tol))
                XCTAssertTrue(val.nextDown.isAlmostEqual(to: val, tolerance: tol))
            }
        }
    }
    
    func testAlmostEqualDouble() {
        
        // Values for testing:
        var values = (Double.leastNonzeroMagnitude.exponent ...
                      Double.greatestFiniteMagnitude.exponent).flatMap {
            exp in [
                Double(sign: .plus, exponent: exp, significand: 1).nextDown,
                Double(sign: .plus, exponent: exp, significand: 1),
                Double(sign: .plus, exponent: exp, significand: 1).nextUp,
                Double(sign: .plus, exponent: exp, significand: .random(in: 1..<2))
            ]
        }
        values.append(.infinity)
        
        // Tolerances for testing:
        let tolerances = [
            2*Double.ulpOfOne, .random(in: .ulpOfOne..<1), Double(1).nextDown
        ]
        
        // NaN is not almost equal to anything, with any tolerance.
        XCTAssertFalse(Double.nan.isAlmostEqual(to: .nan))
        for tol in tolerances {
            XCTAssertFalse(Double.nan.isAlmostEqual(to: .nan, tolerance: tol))
        }
        for val in values {
            XCTAssertFalse(Double.nan.isAlmostEqual(to: val))
            XCTAssertFalse(val.isAlmostEqual(to: .nan))
            for tol in tolerances {
                XCTAssertFalse(Double.nan.isAlmostEqual(to: val, tolerance: tol))
                XCTAssertFalse(val.isAlmostEqual(to: .nan, tolerance: tol))
            }
        }
        
        for val in values {
            XCTAssertTrue(val.isAlmostEqual(to: val))
            XCTAssertTrue(val.isAlmostEqual(to: val.nextUp))
            XCTAssertTrue(val.nextUp.isAlmostEqual(to: val))
            XCTAssertTrue(val.isAlmostEqual(to: val.nextDown))
            XCTAssertTrue(val.nextDown.isAlmostEqual(to: val))
            for tol in tolerances {
                XCTAssertTrue(val.isAlmostEqual(to: val, tolerance: tol))
                XCTAssertTrue(val.isAlmostEqual(to: val.nextUp, tolerance: tol))
                XCTAssertTrue(val.nextUp.isAlmostEqual(to: val, tolerance: tol))
                XCTAssertTrue(val.isAlmostEqual(to: val.nextDown, tolerance: tol))
                XCTAssertTrue(val.nextDown.isAlmostEqual(to: val, tolerance: tol))
            }
        }
    }
    
    func testAlmostZeroFloat() {
        for val in [
            Float.ulpOfOne.squareRoot(), 1, .greatestFiniteMagnitude,
            .infinity, .nan
        ] {
            XCTAssertFalse(val.isAlmostZero())
            XCTAssertFalse((-val).isAlmostZero())
        }
        
        for val in [
            Float.ulpOfOne.squareRoot().nextDown, .leastNormalMagnitude,
            .leastNonzeroMagnitude, 0
        ] {
            XCTAssertTrue(val.isAlmostZero())
            XCTAssertTrue((-val).isAlmostZero())
        }
    }
    
    func testAlmostZeroDouble() {
        for val in [
            Double.ulpOfOne.squareRoot(), 1, .greatestFiniteMagnitude,
            .infinity, .nan
        ] {
            XCTAssertFalse(val.isAlmostZero())
            XCTAssertFalse((-val).isAlmostZero())
        }
        
        for val in [
            Double.ulpOfOne.squareRoot().nextDown, .leastNormalMagnitude,
            .leastNonzeroMagnitude, 0
        ] {
            XCTAssertTrue(val.isAlmostZero())
            XCTAssertTrue((-val).isAlmostZero())
        }
    }
}
