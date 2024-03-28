import Foundation

enum Buttons {
    enum Camera {
        
        static var status: UIButton {
            get {
                let button = UIButton()
                button.setTitle(LocalizedString("camera-point-first", comment: ""), for: .normal)
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
