//
//  Renderable.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 16/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

protocol Renderable {
    init?(_ renderCommand: String)
    func draw(in ctx: CGContext)
}
