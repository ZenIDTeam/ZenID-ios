//
//  Buttons.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 10/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

final class ZenTextButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.setTitleColor(.zenGreen, for: .normal)
        self.setTitleColor(UIColor.zenGreen.withAlphaComponent(0.5), for: .highlighted)
    }
}

class ZenButton: UIButton {
    var textColor: UIColor = .zenTextLight { didSet { setupView() }}
    var outlineColor: UIColor = .zenTextLight { didSet { setupView() }}
    var outline: Bool = false { didSet { setupView() }}
    var size: CGSize = CGSize(width: 300, height: 50)
    let cornerRadius: CGFloat = 5
    
    override var backgroundColor: UIColor? { didSet { setupView() }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.textColor = textColor
        self.titleLabel?.font = .buttonFont
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if outline {
            self.layer.borderColor = outlineColor.cgColor
            self.layer.borderWidth = 2
        }
        else {
            self.dropShadow()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return size
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.65 : 1
        }
    }
}

class CountryButton: UIButton {
    var country: Country = .cz
}

enum Buttons {
    static var startUsing: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-start-using".localized.uppercased(), for: .normal)
            button.outline = true
            return button
        }
    }
    
    static var id: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-id".localized.uppercased(), for: .normal)
            button.backgroundColor = .zenGreen
            return button
        }
    }
    
    static var drivingLicence: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-driving-licence".localized.uppercased(), for: .normal)
            button.backgroundColor = .zenPurple
            return button
        }
    }
    
    static var passport: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-passport".localized.uppercased(), for: .normal)
            button.backgroundColor = .zenPurpleDark
            return button
        }
    }

    static var otherDocument: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-other-document".localized.uppercased(), for: .normal)
            button.outline = true
            return button
        }
    }
    
    static var hologram: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-hologram".localized.uppercased(), for: .normal)
            button.outline = true
            return button
        }
    }
    
    static var selfie: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-selfie".localized.uppercased(), for: .normal)
            button.outline = true
            return button
        }
    }

    static var skip: UIButton {
        get {
            let button = ZenTextButton()
            button.setTitle("btn-skip".localized, for: .normal)
            return button
        }
    }
    
    static var contact: UIButton {
        get {
            let button = ZenTextButton()
            button.setTitle("btn-contact".localized, for: .normal)
            return button
        }
    }
    
    static var logout: UIButton {
        get {
            let button = ZenTextButton()
            button.setTitle("btn-logout".localized, for: .normal)
            return button
        }
    }
    
    static var info: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-app-info".localized.uppercased(), for: .normal)
            button.outline = true
            button.size = CGSize(width: 200, height: 50)
            return button
        }
    }
    
    static var other: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-other-document".localized.uppercased(), for: .normal)
            button.outline = true
            return button
        }
    }

    static var ok: UIButton {
        get {
            let button = ZenButton()
            button.setTitle("btn-ok".localized.uppercased(), for: .normal)
            button.outline = true
            return button
        }
    }
    
    static var country: ZenButton = {
        let button = ZenButton()
        button.outline = true
        return button
    }()
    
    enum Camera {
        static var trigger: UIButton {
            get {
                let button = UIButton()
                button.setImage(#imageLiteral(resourceName: "photoCamera"), for: .normal)
                button.widthAnchor.constraint(equalToConstant: 84).isActive = true
                button.heightAnchor.constraint(equalToConstant: 84).isActive = true
                return button
            }
        }

        static var saveStack: UIButton {
            get {
                let button = UIButton()
                button.titleLabel?.font = .pagesCountLabel
                button.setTitleColor(.zenGreen, for: .normal)
                button.contentHorizontalAlignment = .center
                return button
            }
        }

        static var save: UIButton {
            get {
                let button = UIButton()
                button.setImage(#imageLiteral(resourceName: "photoOk"), for: .normal)
                button.widthAnchor.constraint(equalToConstant: 84).isActive = true
                button.heightAnchor.constraint(equalToConstant: 84).isActive = true
                return button
            }
        }
        
        static var delete: UIButton {
            get {
                let button = UIButton()
                button.setImage(#imageLiteral(resourceName: "Icon-checkFail"), for: .normal)
                button.widthAnchor.constraint(equalToConstant: 42).isActive = true
                button.heightAnchor.constraint(equalToConstant: 42).isActive = true
                return button
            }
        }

        static var status: UIButton {
            get {
                let button = UIButton()
                button.setTitle("camera-point-first".localized, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                button.titleLabel?.numberOfLines = 1
                button.titleLabel?.textAlignment = .center
                button.layer.cornerRadius = 10
                button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
                return button
            }
        }
    }
    
    enum Country {
        static var cz: CountryButton {
            let button = CountryButton()
            button.setImage(#imageLiteral(resourceName: "flag_cz"), for: .normal)
            button.country = .cz
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            return button
        }
        
        static var sk: CountryButton {
            let button = CountryButton()
            button.setImage(#imageLiteral(resourceName: "flag_sk"), for: .normal)
            button.country = .sk
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            return button
        }
    }
}
