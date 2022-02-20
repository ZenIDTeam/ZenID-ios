import Foundation

enum Buttons {
    enum Camera {
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
                button.setTitle(NSLocalizedString("camera-point-first", comment: ""), for: .normal)
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
}
