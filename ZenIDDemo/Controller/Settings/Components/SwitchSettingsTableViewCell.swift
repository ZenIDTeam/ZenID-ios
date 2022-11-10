
//
//  SwitchSettingsTableViewCell.swift
//  ZenIDDemo
//
//  Created by Lukáš Gergel on 28.11.2022.
//  Copyright © 2022 Trask, a.s. All rights reserved.
//

import UIKit

final class SwitchSettingsTableViewCell: UITableViewCell {
    weak var titleLabel: UILabel!
    weak var valueSwitch: UISwitch!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        valueSwitch.removeTarget(nil, action: nil, for: .allEvents)
    }

    private func setupUI() {
        selectionStyle = .none

        let titleLabel = UILabel()
        self.titleLabel = titleLabel

        let valueSwitch = UISwitch()
        self.valueSwitch = valueSwitch

        let firstRowStack = UIStackView(arrangedSubviews: [titleLabel, valueSwitch])
        firstRowStack.axis = .horizontal
        firstRowStack.distribution = .fill
        firstRowStack.alignment = .fill
        firstRowStack.spacing = 8

        let contentStack = UIStackView(arrangedSubviews: [firstRowStack])
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
