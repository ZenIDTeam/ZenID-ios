//
//  DrawingLayer.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 16/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

class DrawingLayer: CALayer {
    var renderables: [Renderable]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.setNeedsDisplay()
            }
        }
    }
    
    override func draw(in ctx: CGContext) {
        renderables?.forEach { $0.draw(in: ctx) }        
    }
}
