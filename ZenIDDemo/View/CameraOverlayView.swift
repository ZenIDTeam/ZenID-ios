//
//  CameraOverlayView.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 14/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

final class CameraOverlayView: UIView {
    private let photoType: PhotoType
    private let documentType: DocumentType
    
    lazy var frameImageView: UIImageView = {
        let imageView = UIImageView(image: targettingReticle)
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var targettingReticle: UIImage {
        get {
            switch documentType {
            case .passport:
                return #imageLiteral(resourceName: "targettingRectPas")
            default:
                return #imageLiteral(resourceName: "targettingRect")
            }
        }
    }
    
//    private var imageContentMode: UIView.ContentMode {
//        switch Defaults.videoGravity {
//        case .resizeAspect:
//            return .scaleAspectFit
//        case .resizeAspectFill:
//            return .scaleAspectFill
//        case .resize:
//            return .scaleToFill
//        default:
//            return .scaleAspectFit
//        }
//    }
    
    init(documentType: DocumentType, photoType: PhotoType, frame: CGRect) {
        self.documentType = documentType
        self.photoType = photoType
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(frameImageView)
        frameImageView.translatesAutoresizingMaskIntoConstraints = false
        let width = frameImageView.widthAnchor.constraint(equalTo: widthAnchor)
        let height = frameImageView.widthAnchor.constraint(equalTo: heightAnchor)
        width.priority = UILayoutPriority(rawValue: 750)
        height.priority = UILayoutPriority(rawValue: 750)
        NSLayoutConstraint.activate([
            width, height,
            frameImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            frameImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupSafeArea(layoutGuide: UILayoutGuide) {
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            frameImageView.leftAnchor.constraint(greaterThanOrEqualTo: layoutGuide.leftAnchor, constant: padding),
            frameImageView.topAnchor.constraint(greaterThanOrEqualTo: layoutGuide.topAnchor, constant: padding)
        ])
    }
}
