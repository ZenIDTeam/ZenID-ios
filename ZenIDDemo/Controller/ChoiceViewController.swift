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
    private let idButton = Buttons.id
    private let drivingLicenceButton = Buttons.drivingLicence
    private let passportButton = Buttons.passport
    private let otherDocumentButton = Buttons.otherDocument
    private let hologramButton = Buttons.hologram
    private let selfieButton = Buttons.selfie
    private let countryButton = Buttons.country
    private let contactButton = Buttons.contact
    private let logoutButton = Buttons.logout
    private lazy var documentButtons = [
        idButton,
        drivingLicenceButton,
        passportButton,
        otherDocumentButton,
        hologramButton,
        //selfieButton
    ]
    private var selectedCountry: Country = .cz
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .bigTitle
        title.text = "title-select".localized
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.textAlignment = .center
        title.textColor = .zenTextLight
        return title
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let versionLabel: UILabel = {
        let versionLabel = UILabel()
        versionLabel.font = .version
        versionLabel.textColor = .zenTextLight
        versionLabel.alpha = 0.7
        versionLabel.text = "verze \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)"
        return versionLabel
    }()
    
    private lazy var toastView: ToastView = {
        let toastView = ToastView()
        toastView.toastLabel.text = "title-success".localized
        return toastView
    }()
    
    private let cachedCameraViewController = CameraViewController(photoType: .front, documentType: .idCard, country: .cz)
    private var scanProcess: ScanProcess?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTargets()
        applyDefaultGradient()

        if Defaults.firstRun {
            navigationController?.pushViewController(WalkthroughViewController(), animated: false)
        }
        
        ensureCredentials()
    }

    override func viewDidAppear(_ animated: Bool) {
        //scanProcess = nil
    }
    
    private func setupView() {
        // Contact button
        view.addSubview(contactButton)
        contactButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingRight: 30)
        
        // Logout button
        view.addSubview(logoutButton)
        logoutButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 30)
        
        // Title view
        view.addSubview(titleLabel)
        titleLabel.anchor(top: contactButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingLeft: 30, paddingRight: 30)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        titleLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)

        // Stack view with buttons
        view.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, left: nil, bottom: nil, right: nil)
        stackView.centerX(to: view)
        stackView.addArrangedSubview(countryButton)
        documentButtons.forEach { stackView.addArrangedSubview($0) }
        updateCountryButton()
        
        // Version
        view.addSubview(versionLabel)
        versionLabel.anchor(top: stackView.bottomAnchor, left: nil, bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingRight: 20)

        // Toast view
        view.addSubview(toastView)
        toastView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        
        cachedCameraViewController.delegate = self
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTargets() {
        contactButton.addTarget(self, action: #selector(contactAction(sender:)), for: .touchUpInside)
        countryButton.addTarget(self, action: #selector(selectCountryAction(sender:)), for: .touchUpInside)
        documentButtons.forEach {
            $0.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
        }
        logoutButton.addTarget(self, action: #selector(logoutAction(sender:)), for: .touchUpInside)
    }
    
    private func updateCountryButton() {
        let countryTitle = "btn-country".localized.uppercased()
        let country = selectedCountry.rawValue.uppercased()
        countryButton.setTitle("\(countryTitle): \(country)", for: .normal)
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
    
    @objc private func contactAction(sender: UIButton) {
        if let emailURL = URL(string: "mailto:\(ZenConstants.contactEmail)"), UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc private func selectAction(sender: UIButton) {
        ensureCredentials { [unowned self] in
            Haptics.shared.select()
            switch sender {
            case self.idButton:
                self.startProcess(.idCard)
            case self.drivingLicenceButton:
                self.startProcess(.drivingLicence)
            case self.passportButton:
                self.startProcess(.passport)
            case self.otherDocumentButton:
                self.startProcess(.otherDocument)
            case self.hologramButton:
                self.startProcess(.hologram)
            case self.selfieButton:
                self.startProcess(.selfie)
            default:
                break
            }
        }
    }
    
    @objc private func logoutAction(sender: UIButton) {
        self.confirm(title: nil, message: "Opravdu chcete smazat přihlašovací údaje?", ok: { [weak self] in
            self?.clearCredentials()
        })
    }
    
    private func startProcess(_ documentType: DocumentType) {
        scanProcess = ScanProcess(documentType: documentType, country: selectedCountry)
        scanProcess?.delegate = self
        scanProcess?.start()
    }
    
    private func showResults(documentType: DocumentType, investigateResponse: InvestigateResponse) {
        debugPrint("Show investigation results")
        let model = ResultsViewModel(documentType: documentType, investigateResponse: investigateResponse)
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
    func didTakePhoto(_ imageData: Data?, type: PhotoType) {
        if let data = imageData {
            scanProcess?.processPhoto(imageData: data, type: type)
        }
    }
    
    func didTakeVideo(_ videoAsset: AVURLAsset?, type: PhotoType) {
        if let videoAsset = videoAsset {
            if let data = try? Data(contentsOf: videoAsset.url) {
                scanProcess?.processPhoto(imageData: data, type: type)
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
                zenidAuthorize(completion: completion)
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
    
    private func zenidAuthorize(completion: @escaping (() -> Void)) {
        let isAuthorized = ZenidSecurity.isAuthorized()
        debugPrint("ZenidSecurity: isAuthorized: \(String(isAuthorized))")
        
        if isAuthorized {
            completion()
            return
        }
        
        let errorMessage: (() -> Void) = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.alert(title: "title-error".localized, message: "ZenID authorization failed")
            }
        }
        if let challengeToken = ZenidSecurity.getChallengeToken() {
            Client()
                .request(API.initSdk(token: challengeToken)) { (response, error) in
                    if let response = response, let responseToken = response.Response {
                        let authorize = ZenidSecurity.authorize(responseToken: responseToken)
                        debugPrint("ZenidSecurity: authorize: \(String(authorize))")
                        if authorize {
                            completion()
                            return
                        } else {
                            errorMessage()
                        }
                    } else {
                        errorMessage()
                    }
                }
        } else {
             errorMessage()
        }
    }
    
    private func clearCredentials() {
        Credentials.shared.clear()
        Haptics.shared.success()
    }
}

//MARK: - Scan process delegate
extension ChoiceViewController: ScanProcessDelegate {
    func willTakePhoto(scanProcess: ScanProcess, photoType: PhotoType) {
        DispatchQueue.main.async { [unowned self] in
            self.cachedCameraViewController.configureController(type: scanProcess.documentType,
                                                                photoType: photoType,
                                                                country: scanProcess.country,
                                                                photosCount: scanProcess.pdfImages.count
            )
        }
                
        DispatchQueue.main.async { [unowned self] in
            guard self.navigationController?.topViewController != self.cachedCameraViewController else { return }

            if self.navigationController?.topViewController is BusyViewController {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.navigationController?.pushViewController(self.cachedCameraViewController, animated: true)
            }
        }
    }
    
    func willProcessData(scanProcess: ScanProcess) {
        DispatchQueue.main.async { [unowned self] in
            guard !(self.navigationController?.topViewController is BusyViewController) else { return }
            
            let busyViewController = BusyViewController()
            busyViewController.title = scanProcess.documentType.title
            self.navigationController?.pushViewController(busyViewController, animated: true)
        }
    }
    
    func didUploadPDF(scanProcess: ScanProcess, result: SampleResult) {
        // The result is always considered successful ATM
        DispatchQueue.main.async { [unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
            self.showSuccess()
        }
    }
    
    func didReceiveSampleResponse(scanProcess: ScanProcess, result: SampleResult) {
        DispatchQueue.main.async { [unowned self] in
            switch result {
            case .error(error: let error):
                self.cachedCameraViewController.showErrorMessage(error.message)
            case .success:
                self.cachedCameraViewController.showSuccess()
            }
        }
    }
    
    func didReceiveInvestigateResponse(scanProcess: ScanProcess, result: ScanProcessResult) {
        DispatchQueue.main.async { [unowned self] in
            switch result {
            case .error(error: _):
                // TODO: Show more meaningful error messages
                self.showError(documentType: scanProcess.documentType, message:"msg-network-error".localized)
            case .success(let data):
                self.showResults(documentType: scanProcess.documentType, investigateResponse: data)
            }
        }
    }
}

//MARK: - Qr scanner delegate
extension ChoiceViewController: QrScannerControllerDelegate {
    func qrSuccess(_ controller: UIViewController, scanDidComplete result: String, completion: (() -> Void)?) {
        if let qr = CredentialsQrCode(value: result), qr.isValid {
            Credentials.shared.update(apiURL: qr.apiURL!, apiKey: qr.apiKey!)
            Haptics.shared.success()
            if let completion = completion {
                zenidAuthorize(completion: completion)
            }
            debugPrint("Credentials updated, apiURL: \(Credentials.shared.apiURL?.absoluteString ?? ""), apiKey: \(Credentials.shared.apiKey ?? "")")
        }
    }
    
    func qrFail(_ controller: UIViewController, error: String) {
    }
    
    func qrCancel(_ controller: UIViewController) {
    }
}
