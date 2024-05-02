//
//  Entities.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-27.
//

import Foundation

@testable import BaseBTS

public struct Entity1 : Entity, HasF1 {
    public var id: UUID
    public var f1: String
}

public struct Entity2 : Entity, HasF2 {
    public var id: UUID
    public var f2: String
}

public struct Entity3 : Entity, HasF1, HasF2 {
    public var id: UUID
    public var f1: String
    public var f2: String
}

