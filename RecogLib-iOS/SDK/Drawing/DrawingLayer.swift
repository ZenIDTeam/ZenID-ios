//
//  DrawingLayer.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 16/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

class DrawingLayer: CALayer {
    var mirrorX = false
    
    private(set) var renderables: [Renderable]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.setNeedsDisplay()
            }
        }
    }
    
    override func draw(in ctx: CGContext) {
        renderables?.forEach { $0.draw(in: ctx) }
    }
    
    func setRenderables(_ renderables: [Renderable]?) {
        guard let renderables = renderables else {
            self.renderables = nil
            return
        }
        var high = [Renderable]()
        var low = [Renderable]()
        for renderable in renderables {
            switch renderable.priority {
            case .high:
                high.append(renderable)
            case .low:
                low.append(renderable)
            }
        }
        self.renderables = high + low
    }
}
