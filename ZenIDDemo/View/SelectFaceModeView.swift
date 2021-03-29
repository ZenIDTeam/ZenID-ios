//
//  FaceModeView.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 27/09/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

class SelectFaceModeView: UIView {

    var selectedFaceMode: FaceMode = .faceLiveness
    var completion: ((FaceMode)->())?
    
    private let faceLivenessButton = Buttons.FaceMode.faceLiveness
    private let selfieButton = Buttons.FaceMode.selfie
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .lightGray
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        stackView.addArrangedSubview(faceLivenessButton)
        stackView.addArrangedSubview(selfieButton)
        
        faceLivenessButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        selfieButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: FaceModeButton) {
        selectedFaceMode = sender.faceMode
        completion?(selectedFaceMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        Log.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 70)
    }
}
