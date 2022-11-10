//
//  IntervalTableViewCell.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import UIKit


final class IntervalTableViewCell: UITableViewCell {
    weak var titleLabel: UILabel!
    weak var valueLabel: UILabel!
    weak var valueSlider: UISlider!
    weak var minLabel: UILabel!
    weak var maxLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        valueSlider.removeTarget(nil, action: nil, for: .allEvents)
    }

    func setupUI() {
        selectionStyle = .none

        let titleLabel = UILabel()
        self.titleLabel = titleLabel
        let valueLabel = UILabel()
        self.valueLabel = valueLabel

        let valueSlider = UISlider()
        self.valueSlider = valueSlider
        let minLabel = UILabel()
        self.minLabel = minLabel
        let maxLabel = UILabel()
        self.maxLabel = maxLabel

        let firstRowStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        firstRowStack.axis = .horizontal
        firstRowStack.distribution = .fill
        firstRowStack.alignment = .fill
        firstRowStack.spacing = 8

        let secondRowStack = UIStackView(arrangedSubviews: [minLabel, valueSlider, maxLabel])
        secondRowStack.axis = .horizontal
        secondRowStack.spacing = 8

        let contentStack = UIStackView(arrangedSubviews: [firstRowStack, secondRowStack])
        contentStack.axis = .vertical
        contentStack.distribution = .fill
        contentStack.alignment = .fill
        contentStack.spacing = 8
        contentView.addSubview(contentStack)

        translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let constraints = contentStack.constraintsForAnchoringTo(boundsOf: contentView, insets: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        NSLayoutConstraint.activate(constraints)
    }
}
