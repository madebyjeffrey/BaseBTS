//
//  BaseElements.swift
//  BaseBTS
//
//  Created by Jeffrey Drake on 2024-04-27.
//

import Foundation

public protocol Entity {
    var id: UUID { get }
}

protocol System {
    func run(world: World)
}
