//
//  WorldTests.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-25.
//
import Foundation

import XCTest
@testable import BaseBTS

final class WorldTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseWorldIsEmpty() {
        let w = World()
        
        XCTAssertEqual(w.entities.count, 0)
    }
    
    func testBaseWorldHasOne() {
        let w = World(entities: [Entity()])
        
        XCTAssertEqual(w.entities.count, 1)
    }
    
    func testBaseWorldHasTwo() {
        let w = World(entities: [Entity(), Entity()])
        
        XCTAssertEqual(w.entities.count, 2)
    }
    
    func testBaseWorldHasOneThenTwo() {
        let w = World(entities: [Entity()])
        
        XCTAssertEqual(w.entities.count, 1)
        
        w.addEntity(Entity())
        
        XCTAssertEqual(w.entities.count, 2)
    }
    
    func testBaseWorldHasOneThenTwoThenOne() {
        let w = World(entities: [Entity()])
        
        XCTAssertEqual(w.entities.count, 1)
        
        let e1 = Entity()
        w.addEntity(e1)
        
        XCTAssertEqual(w.entities.count, 2)
        
        w.removeEntity(byId: e1.id)
        
        XCTAssertEqual(w.entities.count, 1)
    }
    
    func testBaseWorldHasOneThenTwoThenOneThenNone() {
        let e0 = Entity()
        
        let w = World(entities: [e0])
        
        XCTAssertEqual(w.entities.count, 1)
        
        let e1 = Entity()
        w.addEntity(e1)
        
        XCTAssertEqual(w.entities.count, 2)
        
        w.removeEntity(byId: e1.id)
        
        XCTAssertEqual(w.entities.count, 1)
        
        w.removeEntity(byId: e0.id)
        
        XCTAssertEqual(w.entities.count, 0)
        
        XCTAssertTrue(w.isEmpty())
    }

    func testGetEntity() {
        let e0 = Entity()
        
        let w = World(entities: [e0])
        
        XCTAssertEqual(w.entities.count, 1)
        
        let es = w.getEntities()
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e0.id, ex.id)
    }
    
    func testGetEntityByComponentQuery() {
        var e0 = Entity()
        e0.addOrUpdate(component: TestComponent(name: "James"))
        
        let e1 = Entity()
        
        let w = World(entities: [e0, e1])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: TestComponent.identifier)
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e0.id, ex.id)
    }
    
    func testGetEntityByComponentQueryAlternativeOrder() {
        var e0 = Entity()
        e0.addOrUpdate(component: TestComponent(name: "James"))
        
        let e1 = Entity()
        
        let w = World(entities: [e1, e0])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: TestComponent.identifier)
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e0.id, ex.id)
    }
    
    func testGetEntityByCasedComponentQuery() {
        var e0 = Entity()
        e0.addOrUpdate(component: CasedComponent.bareCase)
        
        let e1 = Entity()
        
        let w = World(entities: [e1, e0])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: CasedComponent.identifier)
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e0.id, ex.id)
    }
    
    func testGetEntityByCasedComponentSpecificQuery() {
        var e0 = Entity()
        e0.addOrUpdate(component: CasedComponent.bareCase)
        
        let e1 = Entity()
        
        let w = World(entities: [e1, e0])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: CasedComponent.identifier, {
            guard case CasedComponent.bareCase = $0 else {
                return false
            }
            
            return true
        })
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e0.id, ex.id)
    }
    
    func testGetEntityByCasedComponentSpecificNegativeQuery() {
        var e0 = Entity()
        e0.addOrUpdate(component: CasedComponent.bareCase)
        
        let e1 = Entity()
        
        let w = World(entities: [e1, e0])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: CasedComponent.identifier, {
            guard case CasedComponent.parameterCase(_) = $0 else {
                return false
            }
            
            return true
        })
        
        XCTAssertEqual(es.count, 0)
    }
    
    func testGetEntityByCasedComponentSpecificAltQuery() {
        var e0 = Entity()
        e0.addOrUpdate(component: CasedComponent.parameterCase(4))
        
        let e1 = Entity()
        
        let w = World(entities: [e1, e0])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: CasedComponent.identifier, {
            guard case CasedComponent.bareCase = $0 else {
                return false
            }
            
            return true
        })
        
        XCTAssertEqual(es.count, 0)
    }
    
    func testGetEntityByCasedComponentSpecificAlt2Query() {
        var e0 = Entity()
        e0.addOrUpdate(component: CasedComponent.parameterCase(4))
        
        let e1 = Entity()
        
        let w = World(entities: [e1, e0])
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities(byComponent: CasedComponent.identifier, {
            guard case CasedComponent.parameterCase(_) = $0 else {
                return false
            }
            
            return true
        })
        
        XCTAssertEqual(es.count, 1)
        XCTAssertEqual(es[0].id, e0.id)
    }
}
