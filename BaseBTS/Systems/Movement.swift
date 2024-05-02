//
//  System.swift
//  bts2
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation

public enum MovementErrors : Error {
    case NoLocationComponent
    case PointsToEntityWithLocation
}

// version 1:   assume static targets

public class MovementSystem : System {
    public func run(world: World) {
        // has waypoints
        let waypoints = world.getEntities({ $0 as? HasWaypoints & HasName & HasLocation })
        
        for var e in waypoints {
            do {
                let origin = Vector2D(try e.location.findPosition(world: world))
                
                let waypoint = e.popWaypoint()
                let target = Vector2D(try waypoint.target.findPosition(world: world))
                let speed = Float(waypoint.speed)
                
                let maximumTravel = speed * speed
                let distanceToDestination = origin.distance(to: target)
                
                // case 1: we haven't reached the destination
                if distanceToDestination > maximumTravel {
                    let direction = origin.subtract(from: target).normalize()
                    let destination = direction.multiply(by: speed * speed).add(to: origin)
                    
                    let entities = try world.getEntities({ $0 as? HasLocation })
                        .filter { try $0.location.hasSameLocation(as: destination, in: world) }
                    
                    if entities.isEmpty {
                        e.pushWaypoint(Waypoint(target: .position(destination), speed: waypoint.speed))
                    } else {
                        e.pushWaypoint(Waypoint(target: .entity(entities[0].id), speed: waypoint.speed))
                    }
                } else {
                    // case 2: we have reached it or otherwise would exceed it
                    e.location = waypoint.target
                }
                
                world.updateEntity(e)
            }
            catch {
                print("Error processing entity \(e.id)")
            }
        }
    }
}


