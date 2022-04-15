//
//  Renderable.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 16/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

enum RenderingPriority {
    case low
    case high
}

protocol Renderable {
    var priority: RenderingPriority { get }
    
    init?(_ renderCommand: String)
    func draw(in ctx: CGContext)
}

extension Renderable {
    var priority: RenderingPriority {
        .low
    }
}
