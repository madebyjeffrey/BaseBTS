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
    
    public func count() -> Int {
        entities.count
    }
        
    public func addEntity(_ entity: Entity) {
        entities.append(entity)
    }
    
    public func updateEntity(_ entity: Entity) {
        let i = entities.lastIndex(where: { $0.id == entity.id })
        
        if let i {
            entities[i] = entity
        }
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
    
    public func getEntity(byId id: UUID) throws -> Entity {
        let result = entities.filter({ $0.id == id }).first
        
        if result != nil {
            return result.unsafelyUnwrapped
        } else {
            throw ECSErrors.noEntityWithThatId
        }
    }
       
    public func getEntities<T>(_ mapper: (Entity) -> T?) -> [T] {
        entities.map { mapper($0) }
            .filter { $0 != nil }
            .map { $0.unsafelyUnwrapped }
    }
}
