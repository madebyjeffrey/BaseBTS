//
//  System.swift
//  bts2
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation

protocol System {
    func run(world: World)
}

public enum MovementErrors : Error {
    case NoLocationComponent
    case PointsToEntityWithLocation
}

// version 1:   assume static targets

public class MovementSystem : System {
    private func getOrigin(from e: Entity, withWorld world: World) throws -> Vector2D {
        do {
            let location = try e.getComponent(byId: LocationComponent.identifier)
            
            // easy case- it has its x y
            if case let LocationComponent.position(x: x, y: y) = location {
                return (x: Float(x), y: Float(y))
            }
            
            // not so easy, we need to refer to another component
            if case let LocationComponent.entity(e) = location {
                let e2 = try world.getEntity(byId: e)
                let l2 = try e2.getComponent(byId: LocationComponent.identifier)
                
                if case let LocationComponent.position(x: x, y: y) = l2 {
                    return (x: Float(x), y: Float(y))
                }
            }
            
            throw MovementErrors.NoLocationComponent
        }
        catch ECSErrors.entityHasNoComponent {
            throw MovementErrors.NoLocationComponent
        }
        catch ECSErrors.noEntityWithThatId {
            throw MovementErrors.PointsToEntityWithLocation
        }
    }
    
    private func getDestinationAndSpeed(from e: Entity, withWorld world: World) throws -> (location: Vector2D, warp: Int) {
        do {
            let location = try e.getComponent(byId: DestinationComponent.identifier)
            
            // easy case- it has its x y
            if case let DestinationComponent.position(x: x, y: y, warp: warp) = location {
                return ((x: Float(x), y: Float(y)), warp)
            }
            
            // not so easy, we need to refer to another component
            if case let DestinationComponent.entity(e, warp: warp) = location {
                let e2 = try world.getEntity(byId: e)
                let l2 = try e2.getComponent(byId: LocationComponent.identifier)
                
                if case let LocationComponent.position(x: x, y: y) = l2 {
                    return ((x: Float(x), y: Float(y)), warp)
                }
            }
            
            throw MovementErrors.NoLocationComponent
        }
        catch ECSErrors.entityHasNoComponent {
            throw MovementErrors.NoLocationComponent
        }
        catch ECSErrors.noEntityWithThatId {
            throw MovementErrors.PointsToEntityWithLocation
        }
    }
//
    public func run(world: World) {
//        var concerns = world.getEntities(byComponent: DestinationComponent.identifier)
//        
//        for concern in concerns {
//            var originX: Float
//            var originY: Float
//            
//            do {
//                let origin = try concern.getComponent(byId: LocationComponent.identifier)
//                
//                if case let LocationComponent.entity(eid) = origin {
//                    let le = try world.getEntity(byId: eid)
//                    let loc = try le.getComponent(byId: LocationComponent.identifier)
//                    if case let LocationComponent.position(x: x, y: y) = loc {
//                        originX = Float(x)
//                        originY = Float(x)
//                    }
//                } else if case let LocationComponent.position(x: x, y: y) = origin {
//                    originX = Float(x)
//                    originY = Float(y)
//                }
//            }
//            catch ECSErrors.entityHasNoComponent {
//                print("Entity \(concern.id) does not have a location.")
//                continue
//            }
//            catch ECSErrors.noEntityWithThatId {
//                print("Position Entity \(concern.id) does not exist.")
//                continue
//            }
//            catch {
//                continue
//            }
//        }
    }
}


