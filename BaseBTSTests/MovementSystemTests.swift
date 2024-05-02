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
    
    func testPlanetToPlanet1Turn() throws {
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
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
            
        XCTAssertTrue(s2.waypoints.isEmpty)
        XCTAssertEqual(s2.location, .entity(p2.id))
    }
    
    func testPlanetToPlanet2Turns() throws {
        let p1 = Planet(id: UUID(), name: "Origin", location: .position(x: 50, y: 50))
        let p2 = Planet(id: UUID(), name: "Destination", location: .position(x: 100, y: 50))
        
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .entity(p1.id),
                      waypoints: [Waypoint(target: .entity(p2.id), speed: 5)])
        
        let world = World()
        world.addEntity(p1)
        world.addEntity(p2)
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 3)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
                
        XCTAssertEqual(s2.waypoints.count, 1)
        XCTAssertEqual(s2.location, .position(x: 75, y: 50))
            
        movement.run(world: world)
        
        let s3 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        
        XCTAssertTrue(s3.waypoints.isEmpty)
        XCTAssertEqual(s3.location, .entity(p2.id))
    }
    
    func testPlanetToLocation1Turn() throws {
        let p1 = Planet(id: UUID(), name: "Omicron Persei VIII", location: .position(x: 50, y: 50))
               
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .entity(p1.id),
                      waypoints: [Waypoint(target: .position(x: 50, y: 75), speed: 5)])
        
        let world = World()
        world.addEntity(p1)
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 2)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        
        XCTAssertTrue(s2.waypoints.isEmpty)
        XCTAssertEqual(s2.location, .position(x: 50, y: 75))
    }
    
    func testPlanetToLocation2Turns() throws {
        let p1 = Planet(id: UUID(), name: "Omicron Persei VIII", location: .position(x: 50, y: 50))
               
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .entity(p1.id),
                      waypoints: [Waypoint(target: .position(x: 50, y: 122), speed: 6)])
        
        let world = World()
        world.addEntity(p1)
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 2)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertEqual(s2.waypoints.count, 1)
        XCTAssertEqual(s2.location, .position(x: 50, y: 86))
        
        movement.run(world: world)
        
        let s3 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertTrue(s3.waypoints.isEmpty)
        XCTAssertEqual(s3.location, .position(x: 50, y: 122))
    }
    
    func testLocationToPlanet1Turn() throws {
        let p1 = Planet(id: UUID(), name: "Omicron Persei VIII", location: .position(x: 50, y: 50))
               
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .position(x: 75, y: 50),
                      waypoints: [Waypoint(target: .entity(p1.id), speed: 5)])
        
        let world = World()
        world.addEntity(p1)
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 2)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertEqual(s2.waypoints.count, 0)
        XCTAssertEqual(s2.location, .entity(p1.id))
    }
    
    func testLocationToPlanet2Turns() throws {
        let p1 = Planet(id: UUID(), name: "Omicron Persei VIII", location: .position(x: 50, y: 50))
               
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .position(x: 100, y: 50),
                      waypoints: [Waypoint(target: .entity(p1.id), speed: 5)])
        
        let world = World()
        world.addEntity(p1)
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 2)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertEqual(s2.waypoints.count, 1)
        XCTAssertEqual(s2.location, .position(x: 75, y: 50))
        
        movement.run(world: world)
        
        let s3 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertEqual(s3.waypoints.count, 0)
        XCTAssertEqual(s3.location, .entity(p1.id))
    }
    
    func testLocationToLocation2Turns() throws {
        let s1 = Ship(id: UUID(), name: "Discovery One", location: .position(x: 100, y: 50),
                      waypoints: [Waypoint(target: .position(x: 150, y: 50), speed: 5)])
        
        let world = World()
        world.addEntity(s1)
        
        XCTAssertEqual(world.count(), 1)
        
        let movement = MovementSystem()
        
        movement.run(world: world)
        
        let s2 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertEqual(s2.waypoints.count, 1)
        XCTAssertEqual(s2.location, .position(x: 125, y: 50))
        
        movement.run(world: world)
        
        let s3 = try XCTUnwrap(try? world.getEntity(byId: s1.id) as? Ship)
        XCTAssertEqual(s3.waypoints.count, 0)
        XCTAssertEqual(s3.location, .position(x: 150, y: 50))
    }
}
