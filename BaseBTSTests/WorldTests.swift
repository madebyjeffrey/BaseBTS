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
    var e1: Entity1!
    var e2: Entity2!
    var e3: Entity3!
    
    override func setUpWithError() throws {
        e1 = Entity1(id: UUID(), f1: "Some String")
        e2 = Entity2(id: UUID(), f2: "Another String")
        e3 = Entity3(id: UUID(), f1: "A", f2: "B")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBaseWorldIsEmpty() {
        let w = World()
        
        XCTAssertEqual(w.entities.count, 0)
    }
    
    func testBaseWorldHasOne() {
        let w = World()
        
        w.addEntity(e1)
        
        XCTAssertEqual(w.entities.count, 1)
    }
    
    func testBaseWorldHasTwo() {
        let w = World()
        
        w.addEntity(e1)
        w.addEntity(e2)
        
        XCTAssertEqual(w.entities.count, 2)
    }
    
    func testBaseWorldAddsAndRemoves() {
        let w = World()
        
        XCTAssertEqual(w.entities.count, 0)
        
        w.addEntity(e1)
        
        XCTAssertEqual(w.entities.count, 1)
        
        w.addEntity(e2)
        
        XCTAssertEqual(w.entities.count, 2)
        
        w.removeEntity(byId: e1.id)
        
        XCTAssertEqual(w.entities.count, 1)
        
        w.removeEntity(byId: e2.id)
        
        XCTAssertEqual(w.entities.count, 0)
    }
    
    func testBaseWorldRemoveDoesntRemoveNothing() {
        let w = World()
        
        XCTAssertEqual(w.entities.count, 0)
        
        w.addEntity(e1)
        
        XCTAssertEqual(w.entities.count, 1)
        
        w.removeEntity(byId: UUID())
        
        XCTAssertEqual(w.entities.count, 1)
    }
    
    func testGetEntity() {
        let w = World()
        
        w.addEntity(e1)
        
        XCTAssertEqual(w.entities.count, 1)
        
        let es = w.getEntities()
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e1.id, ex.id)
    }
    
    func testGetEntityByComponentQuery() {
        let w = World()
        
        w.addEntity(e1)
        w.addEntity(e2)
        
        XCTAssertEqual(w.entities.count, 2)
        
        let es = w.getEntities({ $0 as? HasF1 })
        
        XCTAssertEqual(es.count, 1)
        
        let ex = es[0]
        
        XCTAssertEqual(e1.id, ex.id)
    }
}
