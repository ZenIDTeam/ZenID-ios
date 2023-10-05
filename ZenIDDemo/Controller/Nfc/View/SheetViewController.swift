import UIKit

class SheetViewController: UIViewController {
    let contentView: UIView
    let completion: () -> Void
    
    init(_ contentView: UIView, completion: @escaping () -> Void) {
        self.contentView = contentView
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(contentView)
        contentView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 64)
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("OK", for: .normal)
        nextButton.backgroundColor = view.tintColor
        nextButton.layer.cornerRadius = 10
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24, height: 48)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton() {
        dismiss(animated: true) { [weak self] in
            self?.completion()
        }
    }
}
