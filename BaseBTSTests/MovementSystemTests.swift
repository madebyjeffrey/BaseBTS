//
//  MovementSystemTests.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-25.
//

import Foundation


import XCTest
@testable import BaseBTS

final class MovementSystemTests: XCTestCase {
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlanetToPlanet() {
        let p1 = Planet(id: UUID(), name: "Origin", location: .position(x: 50, y: 50))
        let p2 = Planet(id: UUID(), name: "Destination", location: .position(x: 75, y: 50))
        
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .entity(p1.id),
                      waypoints: [Waypoint(target: .entity(p2.id), speed: 5)])
        
        let world = World()
        world.addEntity(p1)
        world.addEntity(p2)
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 3)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try? world.getEntity(byId: s1.id) as? Ship
        
        if let s2 {
            XCTAssertTrue(s2.waypoints.isEmpty)
            
            if case let .entity(id) = s2.location {
                XCTAssertEqual(id, p2.id)
            } else {
                XCTFail("id is not p2")
            }
        } else {
            XCTFail("s2 either doesn't exist or is not a ship")
        }
    }
}
