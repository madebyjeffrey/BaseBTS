//
//  World.swift
//  bts2
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation

public class World {
    internal var entities: [Entity]
    
    public init() {
        self.entities = []
    }
    
    public init(entities: [Entity]) {
        self.entities = entities
    }
    
    public func addEntity(_ entity: Entity) {
        entities.append(entity)
    }
    
    public func removeEntity(byId id: UUID) {
        entities.removeAll(where: { $0.id == id })
    }
    
    public func isEmpty() -> Bool {
        entities.count == 0
    }
    
    public func getEntities() -> [Entity] {
        entities
    }
    
    public func getEntities(byComponent id: Identifier) -> [Entity] {
        entities.filter({ $0.hasComponent(byId: id) })
    }
    
    public func getEntities<C: Component>(byComponent id: Identifier, _ predicate: (C) -> Bool) -> [Entity] {
        entities.filter({ $0.hasComponent(byId: id, predicate) })
    }
    
    public func getEntity(byId id: UUID) throws -> Entity {
        let result = entities.filter({ $0.id == id }).first
        
        if result != nil {
            return result.unsafelyUnwrapped
        } else {
            throw ECSErrors.noEntityWithThatId
        }        
    }
}
