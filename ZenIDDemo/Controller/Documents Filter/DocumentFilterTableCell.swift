//
//  DocumentFilterTableCell.swift
//  ZenIDDemo
//
//  Created by Libor Polehna on 23.06.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import UIKit


final class DocumentFilterTableCell: UITableViewCell {
    
    @IBOutlet weak var roleTitleLabel: UILabel!
    @IBOutlet weak var roleValueLabel: UILabel!
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var countryValueLabel: UILabel!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTitles()
    }
    
    private func setupTitles() {
        roleTitleLabel.text = NSLocalizedString("document-role", comment: "")
        countryTitleLabel.text = NSLocalizedString("document-country", comment: "")
        pageTitleLabel.text = NSLocalizedString("document-page", comment: "")
    }
    
}
