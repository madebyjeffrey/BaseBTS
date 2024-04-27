//
//  Entity.swift
//  bts2
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation

public struct Entity {
    public private(set) var id: UUID
    
    internal var components: Dictionary<Identifier, Component>
    
    internal init() {
        self.id = UUID()
        self.components = Dictionary()
    }
    
    public static func create(with components: Component...) -> Entity {
        create(with: components)
    }
    
    public static func create<C>(with components: C) -> Entity where C: Collection, C.Element == Component {
        var entity = Entity()
        
        for component in components {
            entity.components.updateValue(component, forKey: component.identifier)
        }
        
        return entity
    }
    
    public mutating func addOrUpdate(component: Component) {
        components.updateValue(component, forKey: component.identifier)
    }
    
    public mutating func removeComponent(byIdentifier id: Identifier) {
        components.removeValue(forKey: id)
    }
    
    public func hasComponent(byId id: Identifier) -> Bool {
        components.keys.contains(id)
    }
    
    public func hasComponent<C: Component>(byId id: Identifier, _ predicate: (C) -> Bool) -> Bool {
        do {
            let c = try getComponent(byId: id) as! C
            
            return predicate(c)
        }
        catch {
            return false
        }
    }
    
    public func getComponent(byId id: Identifier) throws -> Component {
        if let value = components[id] {
            return value
        } else {
            throw ECSErrors.entityHasNoComponent
        }
    }
}
