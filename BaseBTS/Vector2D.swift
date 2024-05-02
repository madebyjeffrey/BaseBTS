//
//  Vector2D.swift
//  BaseBTS
//
//  Created by Jeffrey Drake on 2024-04-25.
//

import Foundation

public struct Vector2D {
    var x: Float
    var y: Float
}

extension Vector2D {
    init(x: Int, y: Int) {
        self.x = Float(x)
        self.y = Float(y)        
    }
    
    init(_ input: (x: Int, y: Int)) {
        self.x = Float(input.x)
        self.y = Float(input.y)
    }
    
    func asRoundedPieces() -> (x: Int, y: Int) {
        (Int(x.rounded(.toNearestOrAwayFromZero)), Int(y.rounded(.toNearestOrAwayFromZero)))
    }
    
    static func zero() -> Vector2D {
        Vector2D(x: 0.0, y: 0.0)
    }

    func magnitude() -> Float {
        sqrtf(x * x + y * y)
    }

    func distance(to: Vector2D) -> Float {
        sqrtf(powf(x - to.x, 2) + powf(y - to.y, 2))
    }

    func normalize() -> Vector2D {
        divide(by: magnitude())
    }

    func subtract(from: Vector2D) -> Vector2D {
        Vector2D(x: from.x - self.x, y: from.y - self.y)
    }

    func multiply(by: Float) -> Vector2D {
        Vector2D(x: self.x * by, y: self.y * by)
    }

    func divide(by: Float) -> Vector2D {
        Vector2D(x: self.x / by, y: self.y / by)
    }

    func add(to: Vector2D) -> Vector2D {
        Vector2D(x: self.x + to.x, y: self.y + to.y)
    }

}
