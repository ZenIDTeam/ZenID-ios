//
//  DocumentVerifierSettingsCellController.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentVerifierSettingsCellController: TableCellController {
    
    private let viewModel: DocumentVerifierSettingsValueViewModel
    private weak var valueLabel: UILabel?
    
    init(viewModel: DocumentVerifierSettingsValueViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalTableViewCell", for: indexPath) as! IntervalTableViewCell
        cell.titleLabel.text = viewModel.title
        cell.minLabel.text = String(Int(viewModel.min))
        cell.maxLabel.text = String(Int(viewModel.max))
        cell.valueSlider.minimumValue = viewModel.min
        cell.valueSlider.maximumValue = viewModel.max
        cell.valueSlider.value = viewModel.value
        cell.valueSlider.addTarget(self, action: #selector(valueSliderDidEnd(sender:)), for: .touchUpInside)
        cell.valueSlider.addTarget(self, action: #selector(valueSliderDidChange(sender:)), for: .valueChanged)
        valueLabel = cell.valueLabel
        updateValueLabel(value: viewModel.value)
        return cell
    }
    
    func select() {
        
    }
    
    @objc
    private func valueSliderDidEnd(sender: UISlider) {
        viewModel.onChange(sender.value)
        updateValueLabel(value: sender.value)
    }
    
    @objc
    private func valueSliderDidChange(sender: UISlider) {
        updateValueLabel(value: sender.value)
    }
    
    private func updateValueLabel(value: Float) {
        valueLabel?.text = "\(Int(value))"
    }
    
}

