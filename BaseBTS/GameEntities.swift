//
//  GameEntities.swift
//  BaseBTS
//
//  Created by Jeffrey Drake on 2024-04-27.
//

import Foundation
import DequeModule

public struct Player : Entity, HasName, HasColour { 
    public var id: UUID
    public var name: String
    public var colour: Colour
}

public struct Planet : Entity, HasName, HasLocation {
    public var id: UUID
    public var name: String
    public var location: Location
}

public struct Ship : Entity, HasName, HasLocation, HasWaypoints {
    public var id: UUID
    public var name: String
    public var location: Location
    public var waypoints: Deque<Waypoint>
}
