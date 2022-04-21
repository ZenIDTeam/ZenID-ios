//
//  SelectCountryView.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 13/12/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

class SelectCountryView: UIView {

    var selectedCountry: Country = .Cz
    var completion: ((Country)->())?
    
    private var buttons: [UIButton] {
        [Buttons.BCountry.cz, Buttons.BCountry.sk, Buttons.BCountry.pl, Buttons.BCountry.hr]
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        for button in buttons {
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonAction(sender: CountryButton) {
        selectedCountry = sender.country
        completion?(selectedCountry)
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 70)
    }
}
