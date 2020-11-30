//
//  SelectCountryView.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 13/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

class SelectCountryView: UIView {

    var selectedCountry: Country = .cz
    var completion: ((Country)->())?
    
    private let czButton = Buttons.Country.cz
    private let skButton = Buttons.Country.sk
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        stackView.addArrangedSubview(czButton)
        stackView.addArrangedSubview(skButton)
        
        czButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        skButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: CountryButton) {
        selectedCountry = sender.country
        completion?(selectedCountry)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 70)
    }
}
