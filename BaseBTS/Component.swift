//
//  Component.swift
//  bts2
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation

public protocol Component {
    static var identifier: Identifier { get }
    var identifier: Identifier { get }
}

extension Component {
    public static var identifier: Identifier { Identifier(Self.self) }
    @inline(__always)
    public var identifier: Identifier { Self.identifier }
}


public struct NameComponent : Component {
    public var name: String;
}

public enum LocationComponent : Component {
    case entity(UUID)
    case position(x: Int, y: Int)
}

public enum DestinationComponent : Component {
    case entity(UUID, warp: Int)
    case position(x: Int, y: Int, warp: Int)
}
