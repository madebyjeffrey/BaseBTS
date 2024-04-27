//
//  TestComponents.swift
//  BaseBTSTests
//
//  Created by Jeffrey Drake on 2024-04-24.
//

import Foundation
import BaseBTS

public struct TestComponent : Component, Equatable {
    public var name: String;
}

public struct SecondTestComponent : Component, Equatable {
}

public enum CasedComponent : Component, Equatable {
    case bareCase
    case parameterCase(Int)
}

