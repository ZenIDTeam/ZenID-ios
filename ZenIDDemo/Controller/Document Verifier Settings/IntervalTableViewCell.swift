//
//  IntervalTableViewCell.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 24.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class IntervalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var valueSlider: UISlider!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueSlider.removeTarget(nil, action: nil, for: .allEvents)
    }
    
}
