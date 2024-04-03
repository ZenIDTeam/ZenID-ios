import Foundation
import RecogLib_iOS
import UIKit

@available(iOS 13.0, *)
class ReadNfcViewController: UIViewController {
    private let viewModel: ReadNfcViewModel
    private let infoView = NfcIntroView()
    private let readingView = NfcReadingView()
    private let dataView = NfcInformationDetail()
    private let errorView = NfcReadingError()
    private let questionView = NfcReadingQuestion(NSLocalizedString("nfc-reading-skip-title", comment: ""))
    private let cancelButton = UIButton(type: .roundedRect)
    private let nextButton = UIButton(type: .system)

    private var cancelButtonButtonTitle: String? {
        get { cancelButton.titleLabel?.text }
        set { cancelButton.setTitle(newValue, for: .normal) }
    }

    private var buttonTitle: String? {
        get { nextButton.titleLabel?.text }
        set { nextButton.setTitle(newValue, for: .normal) }
    }
    
    init(viewModel: ReadNfcViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.viewStateListener = self
    }
    
    deinit {
        ApplicationLogger.shared.Debug("ReadNfcViewController.deinit()")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    @objc func didTapNext() {
        viewModel.didTapNext()
    }

    @objc func didTapCancel() {
        viewModel.didTapCancel()
    }

    private func setupLayout() {
        view.addSubview(infoView)
        infoView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 100)

        view.addSubview(readingView)
        readingView.isHidden = true
        readingView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 100)

        view.addSubview(errorView)
        errorView.isHidden = true
        errorView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 100)

        view.addSubview(questionView)
        questionView.isHidden = true
        questionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 100)

        view.addSubview(dataView)
        dataView.isHidden = true
        dataView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 32, paddingBottom: 72)

        nextButton.setTitle(NSLocalizedString("nfc-reading-button-next", comment: ""), for: .normal)
        nextButton.backgroundColor = view.tintColor
        nextButton.layer.cornerRadius = 10
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24, height: 48)

        cancelButton.isHidden = true
        cancelButton.setTitle(NSLocalizedString("nfc-reading-button-cancel", comment: ""), for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        view.addSubview(cancelButton)
        cancelButton.anchor(top: nil, leading: view.leadingAnchor, bottom: nextButton.topAnchor, trailing: view.trailingAnchor, paddingLeft: 24, paddingBottom: 24, paddingRight: 24, height: 48)
    }

    private func presentNotSupported() {
        let vc = SheetViewController(NfcNotAvailable()) { [weak self] in
            self?.viewModel.didCloseSheet()
        }
        present(vc, animated: true)
    }
}

@available(iOS 13.0, *)
extension ReadNfcViewController: ReadNfcViewModelViewStateListener {
    func viewStateDidUpdate(new: ReadNfcViewModel.ViewState, old: ReadNfcViewModel.ViewState?) {
        print("viewStateDidUpdate: new: \(new), old: \(old)")

        infoView.isHidden = true
        readingView.isHidden = true
        dataView.isHidden = true
        errorView.isHidden = true
        questionView.isHidden = true
        cancelButton.isHidden = true
        cancelButtonButtonTitle = NSLocalizedString("nfc-reading-button-cancel", comment: "")

        switch new {
        case .initial:
            infoView.isHidden = false
            buttonTitle = NSLocalizedString("nfc-reading-button-next", comment: "")
        case .notSupported:
            infoView.isHidden = false
            buttonTitle = NSLocalizedString("nfc-reading-button-ok", comment: "")
            presentNotSupported()
        case .reading:
            readingView.isHidden = false
            buttonTitle = NSLocalizedString("nfc-reading-button-cancel", comment: "")
        case let .completed(document):
            dataView.setupContent(document)
            dataView.isHidden = false
            buttonTitle = NSLocalizedString("nfc-reading-button-continue", comment: "")
        case let .error(error):
            errorView.setupView(with: error.localizedDescription)
            errorView.isHidden = false
            buttonTitle = NSLocalizedString("nfc-reading-button-cancel", comment: "")
        case .waitForAnswer:
            cancelButton.isHidden = false
            questionView.isHidden = false
            buttonTitle = NSLocalizedString("nfc-reading-button-skip", comment: "")
            cancelButtonButtonTitle = NSLocalizedString("nfc-reading-button-restart", comment: "")
        case .lostConnection:
            errorView.isHidden = false
            errorView.setupView(with: NSLocalizedString("nfc-reading-error-connection-lost", comment: ""))
            buttonTitle = NSLocalizedString("nfc-reading-button-restart", comment: "")
        }
    }

    private func askForContinuation() {
    }
}

// import SwiftUI
// struct PreviewNfcReader: NfcDocumentReaderProtocol {
//    func read() async throws -> RecogLib_iOS.NfcData {
//        NfcData(document: NFCDocumentModel())
//    }
// }
//
// struct ReadNfcViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        Preview(ReadNfcViewController(viewModel: ReadNfcViewModel(nfcReader: PreviewNfcReader())).view)
//    }
// }
