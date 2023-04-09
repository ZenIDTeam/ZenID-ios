import MRZParser
import NFCDocumentReader
import UIKit

protocol ReadMrzViewControllerDelegate: AnyObject {
    func didReadNfcData(_ data: NFCDocumentModel)
}

@available(iOS 13.0, *)
final class ReadMrzViewController: UIViewController {
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let fromDatePicker = UIDatePicker()
    private let toDatePicker = UIDatePicker()
    private let scanButton = UIButton(type: .system)
    private let nfcButton = UIButton(type: .system)

    public var delegate: ReadMrzViewControllerDelegate?

    var documentNumber: String? {
        didSet {
            textField.text = documentNumber
        }
    }

    var dateOfBirth: Date? {
        didSet {
            guard let dateOfBirth else { return }
            fromDatePicker.date = dateOfBirth
        }
    }

    var dateOfExpiry: Date? {
        didSet {
            guard let dateOfExpiry else { return }
            toDatePicker.date = dateOfExpiry
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        // Configure title label
        titleLabel.text = "Enter MRZ code"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.addSubview(titleLabel)

        // Configure text field
        textField.borderStyle = .roundedRect
        textField.placeholder = "Document number"
        view.addSubview(textField)

        // Configure from date picker
        let fromLabel = UILabel()
        fromLabel.text = "Date of birth:"
        fromLabel.font = UIFont.systemFont(ofSize: 18)
        fromDatePicker.datePickerMode = .date
        view.addSubview(fromLabel)
        view.addSubview(fromDatePicker)

        // Configure to date picker
        let toLabel = UILabel()
        toLabel.text = "Date of expiry:"
        toLabel.font = UIFont.systemFont(ofSize: 18)
        toDatePicker.datePickerMode = .date
        view.addSubview(toLabel)
        view.addSubview(toDatePicker)

        // Configure scan button
        scanButton.setTitle("Scan MRZ code", for: .normal)
        scanButton.backgroundColor = view.tintColor
        scanButton.layer.cornerRadius = 10
        scanButton.tintColor = .white
        scanButton.addTarget(self, action: #selector(scan), for: .touchUpInside)
        view.addSubview(scanButton)

        // Configure nfc button
        nfcButton.setTitle("Read NFC data", for: .normal)
        nfcButton.backgroundColor = view.tintColor
        nfcButton.layer.cornerRadius = 10
        nfcButton.tintColor = .white
        nfcButton.addTarget(self, action: #selector(readNfcData), for: .touchUpInside)
        nfcButton.isEnabled = false
        view.addSubview(nfcButton)

        // Set constraints for title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        // Set constraints for text field
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 40),
        ])

        // Set constraints for from label
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            fromLabel.widthAnchor.constraint(equalToConstant: 150),
        ])

        // Set constraints for from date picker
        fromDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fromDatePicker.topAnchor.constraint(equalTo: fromLabel.topAnchor),
            fromDatePicker.leadingAnchor.constraint(equalTo: fromLabel.trailingAnchor, constant: 10),
            fromDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        // Set constraints for to label
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 24),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            toLabel.widthAnchor.constraint(equalToConstant: 150),
        ])

        // Set constraints for to date picker
        toDatePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDatePicker.topAnchor.constraint(equalTo: toLabel.topAnchor),
            toDatePicker.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 10),
            toDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        // Set constraints for scan button
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scanButton.topAnchor.constraint(equalTo: toDatePicker.bottomAnchor, constant: 16),
            scanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scanButton.heightAnchor.constraint(equalToConstant: 48),
        ])

        // Set constraints for nfc button
        nfcButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nfcButton.topAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 36),
            nfcButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nfcButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nfcButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    var visionViewController: VisionViewController?
    var readNfcViewController: ReadNfcViewController?

    @objc func scan() {
        let vc = VisionViewController()
        vc.completionHandler = { [weak self] mrzCode in
            guard let self else { return }
            if let (number, dob, doe) = self.parse(mrz: mrzCode) {
                valueUpdate(number: number, dateOfBirth: dob, dateOfExpiry: doe)
                self.visionViewController?.dismiss(animated: true)
            }
        }
        visionViewController = vc
        present(vc, animated: true)
    }

    @objc func readNfcData() {
        print("readNfcData()")
        guard let documentNumber else { return }
        guard let dateOfBirth else { return }
        guard let dateOfExpiry else { return }
        let vm = ReadNfcViewModel(.init(number: documentNumber, dateOfBirth: dateOfBirth, dateOfExpiry: dateOfExpiry))
        let vc = ReadNfcViewController(viewModel: vm)
        vc.delegate = self
        readNfcViewController = vc
        navigationController?.pushViewController(vc, animated: true)
    }

    func valueUpdate(number: String, dateOfBirth: Date, dateOfExpiry: Date) {
        documentNumber = number
        self.dateOfBirth = dateOfBirth
        self.dateOfExpiry = dateOfExpiry
        print("💡", number, dateOfBirth, dateOfExpiry, "isValid=\(isValid)")
        nfcButton.isEnabled = isValid
    }

    var isValid: Bool {
        guard let documentNumber else { return false }
        guard let dateOfBirth else { return false }
        guard let dateOfExpiry else { return false }
        let documentNumberIsValid = documentNumber.count >= 8
        let datesAreValid = dateOfBirth < dateOfExpiry
        return documentNumberIsValid && datesAreValid
    }

    func parse(mrz: String) -> (String, Date, Date)? {
        print("mrz = \(mrz)")

        let parser = MRZParser(isOCRCorrectionEnabled: true)
        if let result = parser.parse(mrzString: mrz),
           let docNr = result.documentNumber,
           let dob = result.birthdate,
           let doe = result.expiryDate {
            return (docNr, dob, doe)
        }
        return nil
    }
}

extension ReadMrzViewController: ReadNfcViewControllerDelegate {
    func didReadNfcData(_ data: NFCDocumentModel) {
        delegate?.didReadNfcData(data)
    }
}
