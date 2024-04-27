//
//  Identifier.swift
//  BaseBTS
//
//  Created by Jeffrey Drake on 2024-04-24.
//

// Originally comes from Fireblade ECS

import Foundation

public struct Identifier {
    public typealias Identifer = Int
    public let id: Identifer
}

extension Identifier {
    @usableFromInline
    init<C>(_ componentType: C.Type) where C: Component {
        self.id = Self.makeRuntimeHash(componentType)
    }
    
    internal static func makeRuntimeHash<C>(_ componentType: C.Type) -> Identifer where C: Component {
        ObjectIdentifier(componentType).hashValue
    }
}

extension Identifier : Equatable {}
extension Identifier : Hashable {}
