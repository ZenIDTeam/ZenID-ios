//
//  UIView+Constraints.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import UIKit

extension UIView {
    /// Returns a collection of constraints to anchor the bounds of the current view to the given view.
    ///
    /// - Parameter view: The view to anchor to.
    /// - Returns: The layout constraints needed for this constraint.
    func constraintsForAnchoringTo(boundsOf view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        ]
    }
}
