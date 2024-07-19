//
//  DrawingView.swift
//  RecogLib-iOS
//
//  Created by Vladimir Belohradsky on 18.07.2024.
//  Copyright © 2024 ZenID. All rights reserved.
//

import UIKit 

class DrawingView: UIView {

    override class var layerClass: AnyClass {
        DrawingLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    func render(commands: String, showTextInstructions: Bool) {
        if let drawLayer = layer as? DrawingLayer {
            let renderables = RenderableFactory
                .createRenderables(commands: commands,
                                   showTextInstructions: showTextInstructions)
            drawLayer.setRenderables(renderables)
        }
    }
}
