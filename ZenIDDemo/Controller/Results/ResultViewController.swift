//
//  ResultViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 15/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

final class ResultCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .resultTitle
        label.textColor = .zenPurpleDark
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .resultValue
        label.textColor = .zenPurpleDark
        label.numberOfLines = 0
        return label
    }()

    func configure(with item: InvestigateDataItem) {
        titleLabel.text = item.row.title
        valueLabel.text = item.value
        
        backgroundColor = .white
        contentView.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Title label
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10)
        
        // Value label
        addSubview(valueLabel)
        valueLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ResultViewController: BaseInfoViewController {
    private let viewModel: ResultsViewModel
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.allowsSelection = false
        view.register(ResultCell.self, forCellReuseIdentifier: String(describing: ResultCell.self))
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        view.tableFooterView = UIView()
        return view
    }()
    
    init(model: ResultsViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupBackground() {
        applyPathGradient()
    }
    
    private func image(from model: ResultsViewModel) -> UIImage {
        switch model.documentType {
        case .idCard:
            if let sex = model.investigateResponse.MinedData?.Sex, let value = sex.Sex, value.uppercased() == "F" {
                return #imageLiteral(resourceName: "Icon-OP-zena")
            } else {
                return #imageLiteral(resourceName: "Icon-OP-muz.pdf")
            }
        case .drivingLicence:
            return #imageLiteral(resourceName: "Icon-RP")
        case .passport:
            return #imageLiteral(resourceName: "Icon-CP")
        case .unspecifiedDocument:
            return #imageLiteral(resourceName: "Icon-CP")
        case .otherDocument:
            return #imageLiteral(resourceName: "Icon-CP")
        case .hologram:
            return #imageLiteral(resourceName: "Kruh-HL")
        case .face:
            return #imageLiteral(resourceName: "Kruh-SF")
        }
    }
    
    override func setupView() {
        super.setupView()
        title = viewModel.documentType.title.uppercased()

        imageView.removeFromSuperview()
        backgroundView.removeFromSuperview()

        view.addSubview(self.tableView)
        tableView.anchor(top: view.layoutMarginsGuide.topAnchor, left: view.leftAnchor, bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 20)

        let backImage = UIImageView(image: viewModel.documentType.backgoundImage)
        backImage.contentMode = .scaleAspectFit
        let frontImage = UIImageView(image: image(from: viewModel))
        frontImage.contentMode = .scaleAspectFit
        backImage.addSubview(frontImage)
        frontImage.centerX(to: backImage)
        frontImage.centerY(to: backImage)
        tableView.tableHeaderView = backImage
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultCell.self)) as? ResultCell {
            cell.configure(with: viewModel.values[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }    
}
