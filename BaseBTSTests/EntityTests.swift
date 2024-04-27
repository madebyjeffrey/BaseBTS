//
//  BaseBTSTests.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import XCTest
@testable import BaseBTS

final class EntityTests: XCTestCase {
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateEntity() {
        let entity = Entity.create(with: TestComponent(name: "Test"))
        
        XCTAssertEqual(entity.components.count, 1)
    }
    
    func testAddingSameComponent() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        
        XCTAssertEqual(entity.components.count, 1)
        
        entity.addOrUpdate(component: TestComponent(name: "Other"))
        
        XCTAssertEqual(entity.components.count, 1)
    }
    
    func testAddingAnotherComponent() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        
        XCTAssertEqual(entity.components.count, 1)
        
        entity.addOrUpdate(component: SecondTestComponent())
        
        XCTAssertEqual(entity.components.count, 2)
    }
    
    func testRemovingOneFromTwoComponent() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: SecondTestComponent())
        
        XCTAssertEqual(entity.components.count, 2)
        
        entity.removeComponent(byIdentifier: SecondTestComponent.identifier)
        
        XCTAssertEqual(entity.components.count, 1)
    }
    
    func testRemovingTwoFromTwoComponent() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: SecondTestComponent())
        
        XCTAssertEqual(entity.components.count, 2)
        
        entity.removeComponent(byIdentifier: TestComponent.identifier)
        
        XCTAssertEqual(entity.components.count, 1)
        
        entity.removeComponent(byIdentifier: SecondTestComponent.identifier)
        
        XCTAssertEqual(entity.components.count, 0)
    }
    
    func testHasAComponent() {
        let entity = Entity.create(with: TestComponent(name: "Test"))
        
        XCTAssertTrue(entity.hasComponent(byId: TestComponent.identifier))
    }
    
    func testHasANotComponent() {
        let entity = Entity.create(with: TestComponent(name: "Test"))
        
        XCTAssertFalse(entity.hasComponent(byId: SecondTestComponent.identifier))
    }
    
    func testHasTwoComponents() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: SecondTestComponent())
        
        XCTAssertTrue(entity.hasComponent(byId: TestComponent.identifier))
        XCTAssertTrue(entity.hasComponent(byId: SecondTestComponent.identifier))
    }
    
    func testHasCasedComponent() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: CasedComponent.bareCase)
        
        XCTAssertTrue(entity.hasComponent(byId: TestComponent.identifier))
        XCTAssertFalse(entity.hasComponent(byId: SecondTestComponent.identifier))
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier))
    }
    
    func testGetComponent() {
        let entity = Entity.create(with: TestComponent(name: "Test"))
        
        XCTAssertTrue(entity.hasComponent(byId: TestComponent.identifier))
        XCTAssertFalse(entity.hasComponent(byId: SecondTestComponent.identifier))
        
        XCTAssertNoThrow(try entity.getComponent(byId: TestComponent.identifier))
        XCTAssertThrowsError(try entity.getComponent(byId: SecondTestComponent.identifier))
    }
    
    func testGetCasedComponent() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: CasedComponent.bareCase)
        
        XCTAssertTrue(entity.hasComponent(byId: TestComponent.identifier))
        XCTAssertFalse(entity.hasComponent(byId: SecondTestComponent.identifier))
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier))
        
        XCTAssertNoThrow(try entity.getComponent(byId: CasedComponent.identifier))
    }
    
    func testHasCasedComponentByPredicateCase1() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: CasedComponent.bareCase)
        
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier))
        
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier, {
            if case CasedComponent.bareCase = $0 {
                return true
            } else {
                return false
            }
        }))
    }
    
    func testHasCasedComponentByPredicateCase2() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: CasedComponent.parameterCase(4))
        
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier))
        
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier, {
            if case CasedComponent.parameterCase(_) = $0 {
                return true
            } else {
                return false
            }
        }))
    }
    
    func testHasCasedComponentByPredicateCase2ValidatingValue() {
        var entity = Entity.create(with: TestComponent(name: "Test"))
        entity.addOrUpdate(component: CasedComponent.parameterCase(4))
        
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier))
        
        XCTAssertTrue(entity.hasComponent(byId: CasedComponent.identifier, {
            if case let CasedComponent.parameterCase(n) = $0, n == 4 {
                return true
            } else {
                return false
            }
        }))
    }
}
