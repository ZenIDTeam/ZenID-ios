import Foundation
import NFCDocumentReader
import UIKit

protocol ReadNfcViewControllerDelegate: AnyObject {
    func didReadNfcData(_ data: NFCDocumentModel)
}

@available(iOS 13, *)
class ReadNfcViewController: UIViewController {
    public var delegate: ReadNfcViewControllerDelegate?

    private let viewModel: ReadNfcViewModel
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    private let nextButton = UIButton(type: .system)

    init(viewModel: ReadNfcViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        loadData()
    }

    func loadData() {
        showLoading()

        Task {
            do {
                let _ = try await viewModel.scan()
                DispatchQueue.main.async { [weak self] in
                    self?.hideLoading()
                    self?.tableView.reloadData()
                }

            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.hideLoading()
                    print(error)
                }
            }
        }
    }

    func showLoading() {
        tableView.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
    }

    func hideLoading() {
        tableView.isHidden = false
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }

    @objc func didTapNext() {
        if let document = viewModel.document {
            delegate?.didReadNfcData(document)
        }
    }

    func setupLayout() {
        // Configure loading view
        view.addSubview(loadingView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        tableView.register(TwoColumnTableViewCell.self, forCellReuseIdentifier: "TwoColumnTableViewCell")
        tableView.sectionHeaderHeight = 44
        view.addSubview(tableView)

        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = view.tintColor
        nextButton.layer.cornerRadius = 10
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        view.addSubview(nextButton)

        // Set constraints for loading view
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // Set constraints for table view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //tableView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
        ])

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension ReadNfcViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.section][indexPath.row]

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
        return viewModel.sections[section]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        let label = UILabel()
        label.text = viewModel.sections[section]
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
