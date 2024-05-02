//
//  TestComponents.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation
import BaseBTS

public protocol HasF1 : Entity {    
    var f1: String { get set }
}

public protocol HasF2 : Entity {
    var f2: String { get set }
}
