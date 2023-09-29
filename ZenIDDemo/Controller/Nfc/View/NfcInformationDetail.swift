import RecogLib_iOS
import UIKit

class NfcInformationDetail: UIView {
    enum DataObject {
        case text(String, String)
        case image(UIImage)
        case data(String)
    }

    private let tableView = UITableView()

    private var sections: [String] = []
    private var items: [[DataObject]] = []

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        tableView.register(TwoColumnTableViewCell.self, forCellReuseIdentifier: "TwoColumnTableViewCell")
        tableView.sectionHeaderHeight = 44
        addSubview(tableView)

        // Set constraints for table view
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }

    func setupContent(_ data: NFCDocumentModelType) {
        sections = []
        items = []

        // image
        sections.append("Face image")
        if let passportImage = data.passportImage {
            items.append([
                .image(passportImage),
            ])
        } else {
            items.append([])
        }

        // personal information
        sections.append(NSLocalizedString("nfc-data-personal-information", comment: ""))
        items.append([
            .text(NSLocalizedString("nfc-data-fullname", comment: ""), "\(data.firstName) \(data.lastName)"),
            .text(NSLocalizedString("nfc-data-given-names", comment: ""), "\(data.firstName)"),
            .text(NSLocalizedString("nfc-data-surname", comment: ""), "\(data.lastName)"),
            .text(NSLocalizedString("nfc-data-gender", comment: ""), "\(data.gender)"),
            .text(NSLocalizedString("nfc-data-nationality", comment: ""), "\(data.nationality)"),
            .text(NSLocalizedString("nfc-data-date-of-birth", comment: ""), "\(data.dateOfBirth)"),
            .text(NSLocalizedString("nfc-data-personal-number", comment: ""), "\(data.personalNumber ?? "")"),
        ])

        // validity
        sections.append(NSLocalizedString("nfc-data-chip-information", comment: ""))
        items.append(getChipInfoSection(data))

        // Verification
        sections.append(NSLocalizedString("nfc-data-verification", comment: ""))
        items.append(getVerificationDetailsSection(data))

        // document information
        sections.append(NSLocalizedString("nfc-data-document-information", comment: ""))
        items.append([
            .text(NSLocalizedString("nfc-data-document-type", comment: ""), data.documentType),
            .text(NSLocalizedString("nfc-data-document-subtype", comment: ""), data.documentSubType),
            .text(NSLocalizedString("nfc-data-document-number", comment: ""), data.documentNumber),
            .text(NSLocalizedString("nfc-data-document-country", comment: ""), data.issuingAuthority),
            .text(NSLocalizedString("nfc-data-date-of-expiry", comment: ""), data.documentExpiryDate),
        ])

        // MRZ
        sections.append(NSLocalizedString("nfc-data-mrz-info", comment: ""))
        items.append([
            .data(data.passportMRZ),
        ])

        tableView.reloadData()
    }

    // Build Chip info section
    func getChipInfoSection(_ data: NFCDocumentModelType) -> [DataObject] {
        [
            .text(NSLocalizedString("nfc-data-lds-version", comment: ""), data.LDSVersion),
            .text(NSLocalizedString("nfc-data-data-groups-present", comment: ""), data.dataGroupsPresent.joined(separator: ", ")),
            .text(NSLocalizedString("nfc-data-data-groups-read", comment: ""), data.dataGroupsAvailable.map { $0.name }.joined(separator: ", ")),
        ]
    }

    func getVerificationDetailsSection(_ data: NFCDocumentModelType) -> [DataObject] {

        var authType: String = NSLocalizedString("nfc-data-auth-not-done", comment: "")
        if data.PACEAuthStatus == .success {
            authType = "PACE"
        } else if data.BACAuthStatus == .success {
            authType = "BAC"
        }

        // Do PACE Info
        var paceStatus = NSLocalizedString("nfc-data-not-supported", comment: "")
        if data.isPACESupported {
            switch data.PACEAuthStatus {
            case .notDone:
                paceStatus = "Supported - Not done"
            case .success:
                paceStatus = "SUCCESS"
            case .failed:
                paceStatus = "FAILED"
            @unknown default:
                paceStatus = "@unknown"
            }
        }

        return [
            .text(NSLocalizedString("nfc-data-access-control", comment: ""), authType),
            .text("PACE", paceStatus)
        ]
    }
}

extension NfcInformationDetail: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]

        switch item {
        case let .image(image):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.configure(with: image)
            return cell
        case let .text(label, value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoColumnTableViewCell", for: indexPath) as! TwoColumnTableViewCell
            cell.configure(leftText: label, rightText: value)
            return cell
        case let .data(value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = value
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        let label = UILabel()
        label.text = sections[section]
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(white: 0.5, alpha: 1.0)
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.sectionHeaderHeight
    }
}

class ImageTableViewCell: UITableViewCell {
    // Define the image view
    let customImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Set up the image view
        customImageView.contentMode = .scaleAspectFit
        contentView.addSubview(customImageView)

        // Set the image view constraints
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        customImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        // customImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure the cell with the image
    func configure(with image: UIImage?) {
        customImageView.image = image
    }
}

class TwoColumnTableViewCell: UITableViewCell {
    // Define the left and right labels
    let leftLabel = UILabel()
    let rightLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Set up the left label
        leftLabel.textAlignment = .left
        leftLabel.numberOfLines = 0
        contentView.addSubview(leftLabel)

        // Set up the right label
        rightLabel.textAlignment = .right
        rightLabel.numberOfLines = 0
        contentView.addSubview(rightLabel)

        // Set the label constraints
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 24),
            rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
//        rightLabel.widthAnchor.constraint(equalTo: leftLabel.widthAnchor, multiplier: 1).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure the cell with the left and right values
    func configure(leftText: String, rightText: String) {
        leftLabel.text = leftText
        rightLabel.text = rightText
    }
}
