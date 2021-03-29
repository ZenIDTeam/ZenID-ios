//
//  WalkthroughViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 10/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import RecogLib_iOS

struct WalkthroughPageInfo {
    var title: String
    var description: String
    var image: UIImage
    var isLastPage: Bool = false
}

final class WalkthroughPageViewController: UIViewController {
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .zenPurpleDark
        titleLabel.font = .darkTitle
        return titleLabel
    }()
   
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .zenPurpleDark
        descriptionLabel.font = .darkDescription
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        return descriptionLabel
    }()
    
    private let button = Buttons.startUsing
    
    init(info: WalkthroughPageInfo) {
        super.init(nibName: nil, bundle: nil)
        configure(with: info)
    }
    
    required init?(coder aDecoder: NSCoder) {
        Log.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        // Image
        view.addSubview(imageView)
        imageView.anchor(top: view.layoutMarginsGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80 - customHeightFactor())
        imageView.centerX(to: view)
        
        // Title
        view.addSubview(titleLabel)
        titleLabel.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 59 - customHeightFactor())
        titleLabel.centerX(to: view)
        
        // Description
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left:view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30)
        
        // Button
        view.addSubview(button)
        button.anchor(top: nil, left: nil, bottom: view.layoutMarginsGuide.bottomAnchor, right: nil, paddingBottom: 40)
        button.centerX(to: view)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    private func configure(with info: WalkthroughPageInfo) {
        imageView.image = info.image
        titleLabel.text = info.title
        descriptionLabel.text = info.description
        button.isHidden = !info.isLastPage
    }
    
    @objc private func closeAction() {
        Defaults.firstRun = false
        navigationController?.popViewController(animated: true)
    }
    
    private func customHeightFactor() -> CGFloat {
        if UIScreen.main.nativeBounds.height < 1334 {
            return 20 // For iPhone SE
        }
        return 0
    }
}

final class WalkthroughViewController: UIPageViewController {
    fileprivate let pages: [UIViewController] = {
        return [
            WalkthroughPageViewController(info: WalkthroughPageInfo(title: "walkthrough-title-0".localized, description: "walkthrough-description-0".localized, image: #imageLiteral(resourceName: "Icon-UdajezDokladu"), isLastPage: false)),
            WalkthroughPageViewController(info: WalkthroughPageInfo(title: "walkthrough-title-1".localized, description: "walkthrough-description-1".localized, image: #imageLiteral(resourceName: "Icon-DetekceHologramu"), isLastPage: true))
        ]
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        return pageControl
    }()

    private let skipButton = Buttons.skip
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        isDoubleSided = true
    }
    
    required init?(coder: NSCoder) {
        Log.shared.Error("init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        rewindToStart()
        applyDefaultGradient()
        setupView()
    }
    
    private func setupView() {
        // Page control
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, left: nil, bottom: view.layoutMarginsGuide.bottomAnchor, right: nil)
        pageControl.centerX(to: view)
        
        // Skip button
        view.addSubview(skipButton)
        skipButton.anchor(top: view.layoutMarginsGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingRight: 22)
        skipButton.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
    }
    
    private func rewindToStart(animated: Bool = true) {
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: animated, completion: nil)
            pageControl.currentPage = 0
        }
    }
    
    @objc private func skipAction() {
        Defaults.firstRun = false
        navigationController?.popViewController(animated: true)
    }
}

extension WalkthroughViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        return viewControllerAt(index: viewControllerIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        return viewControllerAt(index: viewControllerIndex + 1)
    }
    
    private func viewControllerAt(index: Int) -> UIViewController? {
        guard case 0..<pages.count = index else { return nil }
        return pages[index]
    }
}

extension WalkthroughViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let vc = pageViewController.viewControllers?.first {
            pageControl.currentPage = pages.firstIndex(of: vc) ?? 0
        }
    }
}
