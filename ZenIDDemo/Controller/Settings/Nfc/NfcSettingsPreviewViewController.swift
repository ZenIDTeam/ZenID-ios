import RecogLib_iOS
import UIKit

class NfcSettingsPreviewViewController: UIViewController {
    // MARK: - Properties

    var settings: DocumentVerifierNfcValidatorSettings {
        didSet {
            updateUI()
        }
    }

    // MARK: - UI Elements

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let numberOfReadingAttemptsLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Reading Attempts:"
        return label
    }()

    let numberOfReadingAttemptsValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let skipNfcAllowedLabel: UILabel = {
        let label = UILabel()
        label.text = "Skip NFC Allowed:"
        return label
    }()

    let skipNfcAllowedValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let noNfcMeansErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "No NFC Means Error:"
        return label
    }()

    let noNfcMeansErrorValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let isEnabledLabel: UILabel = {
        let label = UILabel()
        label.text = "Is Enabled:"
        return label
    }()

    let isEnabledValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let acceptScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Accept Score:"
        return label
    }()

    let acceptScoreValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let scoreStepLabel: UILabel = {
        let label = UILabel()
        label.text = "Score Step:"
        return label
    }()

    let scoreStepValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let isTestEnabledLabel: UILabel = {
        let label = UILabel()
        label.text = "Is Test Enabled:"
        return label
    }()

    let isTestEnabledValueLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    // MARK: - Initialization

    init(settings: DocumentVerifierNfcValidatorSettings) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NFC Validator Settings"
        view.backgroundColor = .white
        setupUI()
        updateUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        // Add UI elements to the stack view
        stackView.addArrangedSubview(numberOfReadingAttemptsLabel)
        stackView.addArrangedSubview(numberOfReadingAttemptsValueLabel)
        stackView.addArrangedSubview(skipNfcAllowedLabel)
        stackView.addArrangedSubview(skipNfcAllowedValueLabel)
        stackView.addArrangedSubview(noNfcMeansErrorLabel)
        stackView.addArrangedSubview(noNfcMeansErrorValueLabel)
        stackView.addArrangedSubview(isEnabledLabel)
        stackView.addArrangedSubview(isEnabledValueLabel)
        stackView.addArrangedSubview(acceptScoreLabel)
        stackView.addArrangedSubview(acceptScoreValueLabel)
        stackView.addArrangedSubview(scoreStepLabel)
        stackView.addArrangedSubview(scoreStepValueLabel)
        stackView.addArrangedSubview(isTestEnabledLabel)
        stackView.addArrangedSubview(isTestEnabledValueLabel)

        // Add the stack view to the main view
        view.addSubview(stackView)

        // Define constraints

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    // MARK: - Update UI

    private func updateUI() {
        // Update the labels with read-only data from the settings struct

        numberOfReadingAttemptsValueLabel.text = "\(settings.numberOfReadingAttempts)"
        skipNfcAllowedValueLabel.text = settings.skipNfcAllowed ? "Yes" : "No"
        noNfcMeansErrorValueLabel.text = settings.noNfcMeansError ? "Yes" : "No"
        isEnabledValueLabel.text = settings.isEnabled ? "Yes" : "No"
        acceptScoreValueLabel.text = "\(settings.acceptScore)"
        scoreStepValueLabel.text = "\(settings.scoreStep)"
        isTestEnabledValueLabel.text = settings.isTestEnabled ? "Yes" : "No"
    }
}
