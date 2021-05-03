//
//  MessagesView.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 18/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

enum MessageType {
    case success
    case error(message: String)
    
    var color: UIColor {
        get {
            switch(self) {
            case .success:
                return UIColor.zenGreen.withAlphaComponent(0.85)
            case .error(_):
                return UIColor.zenRed.withAlphaComponent(0.85)
            }
        }
    }
    
    var message: String {
        get {
            switch(self) {
            case .success:
                return "msg-sample-success".localized
            case .error(let message):
                return message
            }
        }
    }
}

fileprivate class MessageView: UIView {
    var messageType: MessageType
    let label: UILabel = {
        let label = UILabel()
        label.font = .messageLabel
        label.textColor = .zenTextLight
        label.numberOfLines = 0
        return label
    }()
    
    init(type: MessageType) {
        messageType = type
        super.init(frame: .zero)
        
        addSubview(label)
        label.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        label.centerY(to: self)
        label.text = type.message
        backgroundColor = type.color
        clipsToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 65)
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
}

final class MessagesView: UIView {
    private let animationDuration = 0.3
    private let messageTimeToLive = 3.0
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        ApplicationLogger.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMessage(type: MessageType) {
        if stackView.arrangedSubviews.count >= 4 {
            if let removedView = stackView.arrangedSubviews.first {
                stackView.removeArrangedSubview(removedView)
                removedView.removeFromSuperview()
            }
        }

        let messageView = MessageView(type: type)
        messageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        stackView.addArrangedSubview(messageView)
        messageView.isHidden = true
        messageView.layoutIfNeeded()
        
        UIView.animate(withDuration: animationDuration) {
            messageView.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + messageTimeToLive) { [weak self] in
            self?.hideMessage(messageView)
        }
    }
    
    private func hideMessage(_ messageView: MessageView) {
        UIView.animate(withDuration: animationDuration, animations: {
            messageView.frame = CGRect(origin: .zero, size: messageView.intrinsicContentSize)
        }) { [weak self] _ in
            self?.stackView.removeArrangedSubview(messageView)
            messageView.removeFromSuperview()
        }
    }
}
