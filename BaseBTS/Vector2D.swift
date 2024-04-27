//
//  Vector2D.swift
//  BaseBTS
//
//  Created by Jeffrey Drake on 2024-04-25.
//

import Foundation

public typealias Vector2D = (x: Float, y: Float)

public func zero() -> Vector2D {
    (x: 0.0, y: 0.0)
}

public func magnitude(_ input: Vector2D) -> Float {
    sqrtf(input.x * input.x + input.y * input.y)
}

public func distance(from: Vector2D, to: Vector2D) -> Float {
    sqrtf(powf(from.x - to.x, 2) + powf(from.y - to.y, 2))
}

public func normalize(_ input: Vector2D) -> Vector2D {
    divide(input, by: magnitude(input))
}

public func subtract(take: Vector2D, from: Vector2D) -> Vector2D {
    (x: from.x - take.x, from.y - take.y)
}

public func multiply(_ input: Vector2D, by: Float) -> Vector2D {
    (x: input.x * by, y: input.y * by)
}

public func divide(_ input: Vector2D, by: Float) -> Vector2D {
    (x: input.x / by, y: input.y / by)
}
