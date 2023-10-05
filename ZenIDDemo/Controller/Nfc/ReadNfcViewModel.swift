import CoreNFC
import RecogLib_iOS

protocol ReadNfcViewModelViewStateListener: AnyObject {
    func viewStateDidUpdate(new: ReadNfcViewModel.ViewState, old: ReadNfcViewModel.ViewState?)
}

enum ReadNfcViewModelError: Error {
    case noData
}

protocol NfcReadCompletionDelegate: AnyObject {
    func didReadNfcData(data: NfcData)
    func didCancel()
    func didSkipNfc()
}

final class ReadNfcViewModel {
    enum ViewState {
        case initial
        case notSupported
        case error(Error)
        case waitForAnswer(Error)
        case lostConnection
        case reading
        case completed(NFCDocumentModelType)
    }

    private let nfcReader: NfcDocumentReaderProtocol
    private let configuration: DocumentVerifierNfcValidatorSettings

    weak var viewStateListener: ReadNfcViewModelViewStateListener?

    var nfcData: NfcData?
    var skipNfcAllowed: Bool {
        configuration.skipNfcAllowed
    }

    weak var delegate: NfcReadCompletionDelegate?

    private var _viewState: ViewState = .initial
    var viewState: ViewState {
        get { _viewState }
        set {
            let prev = _viewState
            _viewState = newValue
            DispatchQueue.main.async { [weak self] in
                self?.viewStateListener?.viewStateDidUpdate(new: newValue, old: prev)
            }
        }
    }

    init(nfcReader: NfcDocumentReaderProtocol, configuration: DocumentVerifierNfcValidatorSettings) {
        self.nfcReader = nfcReader
        self.configuration = configuration
    }

    deinit {
        ApplicationLogger.shared.Debug("ReadNfcViewModel.deinit()")
    }

    func didTapNext() {
        switch viewState {
        case .initial, .lostConnection:
            #if targetEnvironment(simulator)
                starReadingInSimulator()
            #else
                if NFCNDEFReaderSession.readingAvailable {
                    startReading()
                } else {
                    showReadingNotAvailable()
                }
            #endif
        case .error:
            delegate?.didCancel()
        case .completed:
            guard let data = nfcData else { return }
            delegate?.didReadNfcData(data: data)
        case .waitForAnswer:
            delegate?.didSkipNfc()
        default:
            break
        }
    }

    func didTapCancel() {
        if case .waitForAnswer = viewState {
            viewState = .initial
            didTapNext()
        } else {
            delegate?.didCancel()
        }
    }

    private func showReadingNotAvailable() {
        viewState = .notSupported
    }

    private func startReading() {
        viewState = .reading

        Task {
            do {
                let nfcData = try await nfcReader.read()
                DispatchQueue.main.async { [weak self] in
                    self?.nfcData = nfcData
                    if let document = nfcData.document {
                        self?.viewState = .completed(document)
                    } else {
                        self?.viewState = .error(ReadNfcViewModelError.noData)
                    }
                }
            } catch {
                if skipNfcAllowed, let readerError = error as? NfcDocumentReaderError {
                    // UnexpectedError - timeout
                    // ResponseError - mapped for various mutual auth. errors
                    switch readerError {
                    case .ResponseError, .UnexpectedError, .InvalidMRZKey:
                        viewState = .waitForAnswer(error)
                        return
                    default:
                        break
                    }
                }

                if let readerError = error as? NfcDocumentReaderError, case .LostConnection = readerError {
                    viewState = .lostConnection
                    return
                }

                viewState = .error(error)
            }
        }
    }

    func didCloseSheet() {
        viewState = .initial
    }

    #if targetEnvironment(simulator)
        func starReadingInSimulator() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self else { return }
                if self.skipNfcAllowed {
                    self.viewState = .waitForAnswer(NfcDocumentReaderError.UserCanceled)
                } else {
                    self.viewState = .error(NfcDocumentReaderError.UserCanceled)
                }
//                let nfcDocument = SimNFCDocumentModel(passportImage: UIImage(named: "avatar"))
//                self?.nfcData = NfcData(document: nfcDocument)
//                self?.viewState = .completed(nfcDocument)
            }
        }
    #endif
}
