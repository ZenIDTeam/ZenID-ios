//
//  ChoiceViewController.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 10/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI
import RecogLib_iOS
import os

final class ChoiceViewController: UIViewController {
    private let countryButton = Buttons.country
    private let idButton = Buttons.id
    private let drivingLicenceButton = Buttons.drivingLicence
    private let passportButton = Buttons.passport
    private let documentsFilterButton = Buttons.documentsFilter
    private let otherDocumentButton = Buttons.otherDocument
    private let hologramButton = Buttons.hologram
    private let faceButton = Buttons.face
    private let logsButton = Buttons.logs
    private let webViewButton = Buttons.webView
    
    private let documentsValidator: DocumentsFilterValidator = DocumentsFilterValidatorComposer.compose()
    private var settingsCoordinator: SettingsCoordinator?
    
    private lazy var documentButtons = [
        idButton,
        drivingLicenceButton,
        passportButton,
        otherDocumentButton,
        documentsFilterButton,
        hologramButton,
        //faceButton,
        logsButton,
        webViewButton
    ]
    
    private var selectedCountry: Country {
        get { return Defaults.selectedCountry }
        set { Defaults.selectedCountry = newValue }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private lazy var toastView: ToastView = {
        let toastView = ToastView()
        toastView.toastLabel.text = "title-success".localized
        return toastView
    }()
    
    private func configureTitleLabel(label: UILabel) {
        label.font = .title
        label.text = "title-select".localized
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.textColor = .zenTextLight
    }
    
    private let cachedCameraViewController = CameraViewController(photoType: .front, documentType: .idCard, faceMode: .faceLiveness, dataType: .picture)
    private var scanProcess: ScanProcess?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTargets()
        applyDefaultGradient()

        if Defaults.firstRun {
            navigationController?.pushViewController(WalkthroughViewController(), animated: false)
        }
        
        navigationItem.title = NSLocalizedString("app_name", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ensureCredentials()
    }
    
    private func setupView() {
        // Logout button
        //view.addSubview(logoutButton)
        //logoutButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 30)
        
        // Title view
        //view.addSubview(titleLabel)
        //titleLabel.anchor(top: contactButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        //titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        //titleLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        
        configureTitleLabel(label: titleLabel)
        setupStackView()
        stackView.addArrangedSubview(countryButton)
        documentButtons.forEach { button in
            button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
            stackView.addArrangedSubview(button)
        }
        updateCountryButton()

        // Toast view
        //view.addSubview(toastView)
        //toastView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        
        cachedCameraViewController.delegate = self
        
        setupScrollView()
        setupNavigationBar()
    }
    
    private func setupScrollView() {
        scrollContentView.backgroundColor = .clear
    }
    
    private func setupStackView() {
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 15.0
    }
    
    private func setupNavigationBar() {
        let settingsBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .organize,
            target: self,
            action: #selector(settingsBarButtonPressed)
        )
        navigationItem.rightBarButtonItem = settingsBarButtonItem
    }
    
    @objc
    private func settingsBarButtonPressed() {
        ensureCredentials { [weak self] in
            guard let self = self else { return }
            self.settingsCoordinator = SettingsCoordinator()
            self.present(self.settingsCoordinator!.start(), animated: true, completion: nil)
        }
    }
    
    private func setupTargets() {
        countryButton.addTarget(self, action: #selector(selectCountryAction(sender:)), for: .touchUpInside)
        documentButtons.forEach {
            $0.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
        }
    }
    
    private func updateCountryButton() {
        let title = "btn-country".localized.uppercased()
        let country = selectedCountry.rawValue.uppercased()
        countryButton.setTitle("\(title): \(country)", for: .normal)
    }
    
    @objc private func selectCountryAction(sender: UIButton) {
        let popup = UIViewController()
        let countryView = SelectCountryView()
        popup.view.addSubview(countryView)
        countryView.centerX(to: popup.view)
        countryView.centerY(to: popup.view)
        popup.view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        popup.definesPresentationContext = true
        
        present(popup, animated: true, completion: nil)
                
        countryView.completion = { [weak self] country in
            self?.selectedCountry = country
            self?.updateCountryButton()
            popup.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func selectAction(sender: UIButton) {
        //cachedCameraViewController.removeWebViewOverlay()
        ensureCredentials { [unowned self] in
            Haptics.shared.select()
            switch sender {
            case self.idButton:
                let isLivenessVideo = ConfigServiceComposer.compose().load().isLivenessVideo
                self.startProcess(.idCard, dataType: isLivenessVideo ? .video : .picture)
            case self.drivingLicenceButton:
                self.startProcess(.drivingLicence)
            case self.passportButton:
                self.startProcess(.passport)
            case self.otherDocumentButton:
                self.startProcess(.otherDocument)
            case self.hologramButton:
                self.startProcess(.documentVideo)
            case self.faceButton:
                self.startProcess(.face)
            case self.logsButton:
                self.shareLogFile()
            case self.documentsFilterButton:
                self.startProcess(.filter)
            case self.webViewButton:
                startProcess(.idCard)
                //cachedCameraViewController.addWebViewOverlay()
            default:
                break
            }
        }
    }
    
    private func startProcess(_ documentType: DocumentType, dataType: DataType = .picture) {
        if validateInput(documentType) {
            scanProcess = createScanProcess(documentType: documentType, country: selectedCountry)
            scanProcess?.delegate = self
            scanProcess?.start()
        } else {
            alert(
                title: NSLocalizedString("title-warning", comment: ""),
                message: NSLocalizedString("document-filter-invalid-input", comment: "")
            )
        }
    }
    
    private func validateInput(_ documentType: DocumentType) -> Bool {
        let document = Document(
            role: RecoglibMapper.documentRole(from: documentType, role: nil),
            country: RecoglibMapper.country(from: selectedCountry),
            page: nil, code: nil
        )
       return documentsValidator.validate(input: .init(documents: [document]))
    }
    
    private func restartProcess(currentScanProcess: ScanProcess) {
        currentScanProcess.delegate = nil
        self.scanProcess = nil
        self.scanProcess = createScanProcess(
            documentType: currentScanProcess.documentType,
            country: currentScanProcess.country
        )
        self.scanProcess!.delegate = self
        self.scanProcess!.start()
    }
    
    private func createScanProcess(documentType: DocumentType, country: Country) -> ScanProcess {
        .init(
            documentType: documentType,
            country: country,
            selfieSelectionLoader: SelfieSelectionLoaderComposer.compose()
        )
    }
    
    private func shareLogFile() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let filePath = ZenIDLogger.shared.getLogArchivePath() else { return }
            guard Foundation.FileManager.default.fileExists(atPath: filePath) else { return }
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            var filesToShare = [Any]()
            filesToShare.append(fileURL)
            self.shareFiles(filesToShare: filesToShare)
        }
    }

    private func showResults(documentType: DocumentType, investigateResponse: InvestigateResponse) {
        ApplicationLogger.shared.Verbose("Show investigation results")
        let model = ResultsViewModel(documentType: investigateResponse.MinedData?.DocumentCode?.documentType ?? documentType, investigateResponse: investigateResponse)
        let resultsViewController = ResultViewController(model: model)
        navigationController?.setViewControllers([self, resultsViewController], animated: true)
    }

    fileprivate func showSuccess() {
        toastView.show()
    }
    
    fileprivate func showError(documentType: DocumentType, message: String) {
        let errorViewController = ErrorViewController()
        errorViewController.topTitle = documentType.title
        errorViewController.messageLabel.text = message
        errorViewController.documentType = documentType
        self.navigationController?.setViewControllers([self, errorViewController], animated: true)
    }
}

extension ChoiceViewController: CameraViewControllerDelegate {
    func didTakePhoto(_ imageData: Data?, type: PhotoType, result: UnifiedResult?) {
        if let data = imageData {
            scanProcess?.processPhoto(imageData: data, type: type, result: result, dataType: .picture)
        }
    }
    
    func didTakeVideo(_ videoURL: URL?, type: PhotoType) {
        if let url = videoURL {
            if let data = try? Data(contentsOf: url) {
                scanProcess?.processPhoto(imageData: data, type: type, result: nil, dataType: .video)
            }
        }
    }
    
    func didFinishPDF() {
        scanProcess?.uploadPhotosPDF()
    }
}

//MARK: - Credentials
extension ChoiceViewController {
    private func ensureCredentials(completion: (() -> Void)? = nil) {
        if Credentials.shared.isValid() {
            if let completion = completion {
                zenidAuthorize(completion: { _ in
                    DispatchQueue.main.async {
                        completion()
                    }
                })
            }
            return
        }
        
        let qrScannerController = QrScannerController()
        qrScannerController.delegate = self
        qrScannerController.successCompletion = completion
        if #available(iOS 13.0, *) {
            qrScannerController.modalPresentationStyle = .overFullScreen
        } else {
            qrScannerController.modalPresentationStyle = .fullScreen
        }
        self.present(qrScannerController, animated: false)
    }
    
    private func zenidAuthorize(completion: @escaping ((Bool) -> Void)) {
        let isAuthorized = ZenidSecurity.isAuthorized()
        ApplicationLogger.shared.Verbose("ZenidSecurity: isAuthorized: \(String(isAuthorized))")
        
        if isAuthorized {
            completion(true)
            return
        }
        
        let errorMessage: (() -> Void) = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.alert(title: "title-error".localized, message: "alert-authorization-failed".localized)
            }
        }
        if let challengeToken = ZenidSecurity.getChallengeToken() {
            Client()
                .request(API.initSdk(token: challengeToken)) { (response, error) in
                    if let response = response, let responseToken = response.Response {
                        let authorize = ZenidSecurity.authorize(responseToken: responseToken)
                        ApplicationLogger.shared.Verbose("ZenidSecurity: authorize: \(String(authorize))")
                        if authorize {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            errorMessage()
                        }
                    } else {
                        completion(false)
                        errorMessage()
                    }
                }
        } else {
            completion(false)
            errorMessage()
        }
    }
}

//MARK: - Scan process delegate
extension ChoiceViewController: ScanProcessDelegate {
    func willTakePhoto(scanProcess: ScanProcess, photoType: PhotoType) {
        DispatchQueue.main.async { [weak self] in
            DocumentsFilterLoaderComposer.compose().load { [weak self] result in
                let documents = (try? result.get()) ?? []
                DocumentVerifierSettingsLoaderComposer.compose().load { [weak self] result in
                    let settings = (try? result.get()) ?? .init()
                    SelfieSelectionLoaderComposer.compose().load { [weak self] result in
                        let faceMode = (try? result.get())
                        guard let self = self else { return }
                        self.cachedCameraViewController.configureController(
                            type: scanProcess.documentType,
                            photoType: photoType,
                            country: scanProcess.country,
                            faceMode: faceMode,
                            documents: documents,
                            documentSettings: settings,
                            config: ConfigServiceComposer.compose().load()
                        )
                        //let viewController = MyViewController()
                        //self.navigationController?.pushViewController(self.cachedCameraViewController, animated: true)
                    }
                }
            }
        }
                
        DispatchQueue.main.async { [unowned self] in
            guard self.navigationController?.topViewController != self.cachedCameraViewController else { return }

            if self.isBusyViewControllerPresented() {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.navigationController?.pushViewController(self.cachedCameraViewController, animated: true)
            }
        }
    }
    
    func willProcessData(scanProcess: ScanProcess) {
        DispatchQueue.main.async { [unowned self] in
            guard !self.isBusyViewControllerPresented() else { return }
            showBusyViewController(title: scanProcess.documentType.title)
        }
    }
    
    private func isBusyViewControllerPresented() -> Bool {
        navigationController?.topViewController is BusyViewController
    }
    
    func didUploadPDF(scanProcess: ScanProcess, result: SampleResult) {
        // The result is always considered successful ATM
        DispatchQueue.main.async { [unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
            self.showSuccess()
        }
    }
    
    func didReceiveSampleResponse(scanProcess: ScanProcess, result: SampleResult) {
        switch result {
        case .error(error: let error):
            DispatchQueue.main.async { [weak self] in
                if self?.isBusyViewControllerPresented() ?? false {
                    self?.popToCameraViewController()
                }
                DispatchQueue.main.async {
                    self?.alert(title: "title-error".localized, message: "alert-error-upload-sample".localized, ok: {
                        self?.restartProcess(currentScanProcess: scanProcess)
                        self?.cachedCameraViewController.showErrorMessage(error.message)
                    })
                }
            }
        case .success:
            DispatchQueue.main.async { [unowned self] in
                self.cachedCameraViewController.showSuccess()
            }
        }
    }
    
    func didReceiveInvestigateResponse(scanProcess: ScanProcess, result: ScanProcessResult) {
        DispatchQueue.main.async { [unowned self] in
            switch result {
            case .error(error: _):
                self.popToCameraViewController()
                self.showError(documentType: scanProcess.documentType, message:"msg-network-error".localized)
            case .success(let data, let type):
                if type == .filter {
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.showResults(documentType: scanProcess.documentType, investigateResponse: data)
                }
            }
        }
    }
    
    private func popToCameraViewController() {
        let cameraViewController = navigationController?.viewControllers.first(where: { $0 is CameraViewController })
        if let cameraVC = cameraViewController {
            navigationController?.popToViewController(cameraVC, animated: true)
        }
    }
    
    func didFinishAndWaiting(scanProcess: ScanProcess) {
        if isBusyViewControllerPresented() {
            return
        }
        showBusyViewController(title: scanProcess.documentType.title)
    }
    
    private func showBusyViewController(title: String) {
        let busyViewController = BusyViewController()
        busyViewController.title = title
        navigationController?.pushViewController(busyViewController, animated: true)
    }
}

//MARK: - Qr scanner delegate
extension ChoiceViewController: QrScannerControllerDelegate {
    func qrSuccess(_ controller: UIViewController, scanDidComplete result: String, completion: (() -> Void)?) {
        if let qr = CredentialsQrCode(value: result), qr.isValid {
            Credentials.shared.update(apiURL: qr.apiURL!, apiKey: qr.apiKey!)
            Haptics.shared.success()
            if let completion = completion {
                zenidAuthorize(completion: { isAuthorized in
                    if !isAuthorized {
                        Credentials.shared.clear()
                    } else {
                        completion()
                    }
                })
            }
            ApplicationLogger.shared.Verbose("Credentials updated, apiURL: \(Credentials.shared.apiURL?.absoluteString ?? ""), apiKey: \(Credentials.shared.apiKey ?? "")")
        }
    }
    
    func qrFail(_ controller: UIViewController, error: String) {
    }
    
    func qrCancel(_ controller: UIViewController) {
    }
}
