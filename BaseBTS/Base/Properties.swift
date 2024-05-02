//
//  Component.swift
//  bts2
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation
import DequeModule

public protocol HasName : Entity {
    var name: String { get set }
}

public struct Colour {
    var red: Int
    var green: Int
    var blue: Int
}

public protocol HasColour : Entity {
    var colour: Colour { get }
}

public enum Location {
    case entity(UUID)
    case position(x: Int, y: Int)
}

public enum LocationErrors : Error {
    case HasNoTerminalEntityWithLocation
}

public extension Location {
    func findPosition(world: World) throws -> (x: Int, y: Int) {
        if case let .position(x, y) = self {
            return (x, y)
        }
        
        if case let .entity(uuid) = self {
            do {
                var entity = try world.getEntity(byId: uuid)
                
                guard let location = entity.self as? HasLocation else {
                    throw LocationErrors.HasNoTerminalEntityWithLocation
                }
                
                return try location.location.findPosition(world: world)
            } catch {
                throw LocationErrors.HasNoTerminalEntityWithLocation
            }
        }
        
        throw LocationErrors.HasNoTerminalEntityWithLocation
    }
    
    func hasSameLocation(as v: Vector2D, in world: World) throws -> Bool {
        let (x1, y1) = try findPosition(world: world)
        
        let (x2, y2) = v.asRoundedPieces()
        
        return x2 == x1 && y2 == y1
    }
    
    func hasLocation(world: World, x: Int, y: Int) throws -> Bool {
        let (x1, y1) = try findPosition(world: world)
        
        return x == x1 && y == y1
    }
    
    static func position(_ v: Vector2D) -> Location {
        let (x, y) = v.asRoundedPieces()
        
        return .position(x: x, y: y)
    }
}

public protocol HasLocation : Entity {
    var location: Location { get set }
}

public enum OrderType {
    case none
//    case transport(fuel: Int, minerals: Int, colonists: Int)
//    case colonize
//    case remoteMining
//    case mergeWithFleet(with: UUID)
//    case scrapFleet
//    case transferFleet(to: UUID)
//    case patrol(within: Int)
//    case route
}

public struct Waypoint {
    var target: Location
    var speed: Int
    var order: OrderType = .none
}

public protocol HasWaypoint : Entity {
    var waypoint: Waypoint { get set }
}

public protocol HasWaypoints : Entity {
    var waypoints: Deque<Waypoint> { get set }
}

public extension HasWaypoints {
    mutating func popWaypoint() -> Waypoint {
        self.waypoints.removeFirst()
    }
    
    mutating func pushWaypoint(_ waypoint: Waypoint) {
        self.waypoints.prepend(waypoint)
    }
}

