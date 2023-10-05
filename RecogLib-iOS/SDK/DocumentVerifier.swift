import CoreMedia
import Foundation

public class DocumentVerifier {
    private var cppObject: UnsafeRawPointer?

    public var documentRole: DocumentRole?
    public var country: Country?
    public var page: PageCodes?
    public var code: DocumentCodes?
    public let settings: DocumentVerifierSettings?

    public var documentsInput: DocumentsInput? {
        didSet {
            acceptableInputJson = documentsInput?.acceptableInputJson()
        }
    }

    public var language: SupportedLanguages

    public var showDebugInfo: Bool = false {
        didSet {
            setDocumentDebugInfo(cppObject, showDebugInfo)
        }
    }

    private var acceptableInputJson: String?

    public init(role: DocumentRole?, country: Country?, page: PageCodes?, code: DocumentCodes?, language: SupportedLanguages, settings: DocumentVerifierSettings? = nil) {
        documentRole = role
        self.country = country
        self.page = page
        self.code = code
        self.language = language
        self.settings = settings

        var verifierSettings = createDocumentVerifierSettings(settings: settings)
        cppObject = getDocumentVerifier(&verifierSettings)
    }

    public init(input: DocumentsInput, language: SupportedLanguages, settings: DocumentVerifierSettings? = nil) {
        acceptableInputJson = input.acceptableInputJson()
        self.language = language
        self.settings = settings

        var verifierSettings = createDocumentVerifierSettings(settings: settings)
        cppObject = getDocumentVerifier(&verifierSettings)
    }

    public func loadModels(_ loader: DocumentVerifierModels, mrzModelsPath: URL? = nil) {
        loader.loadPointer { pointer, data, modelName in
            RecogLib_iOS.loadModel(self.cppObject, pointer, data.count)
            ApplicationLogger.shared.Info("Loaded model: \(modelName)")
        }

        if let mrzModelsPath {
            var absolutePath = mrzModelsPath.absoluteString
            absolutePath = absolutePath.replacingOccurrences(of: "file://", with: "")
            let path = absolutePath.toUnsafeMutablePointer()
            RecogLib_iOS.loadTesseractModel(cppObject, path)
        }
    }

    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.verify(cppObject, buffer, &document, acceptableInputJson?.toUnsafeMutablePointer())
        return DocumentResult(document: document)
    }

    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.verifyImage(cppObject, imageBuffer, &document, acceptableInputJson?.toUnsafeMutablePointer())
        return DocumentResult(document: document)
    }

    public func update(settings: DocumentVerifierSettings) {
        var settings = createDocumentVerifierSettings(settings: settings)
        updateDocumentVerifierSettings(cppObject, &settings)
    }

    public func validate(input: DocumentsInput) -> Bool {
        let size = validateDocumentsInput(cppObject, input.acceptableInputJson().toUnsafeMutablePointer())
        return size > 0
    }

    public func beginHologramVerification() {
        RecogLib_iOS.beginHologramVerification(cppObject)
    }

    public func endHologramVerification() {
        RecogLib_iOS.endHologramVerification(cppObject)
    }

    public func reset() {
        RecogLib_iOS.reset(cppObject)
    }

    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var document = createDocumentInfo(orientation: orientation)
        let cString = RecogLib_iOS.getDocumentRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &document)
        defer { free(cString) }

        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }

        return result
    }

    private func createDocumentInfo(orientation: UIInterfaceOrientation) -> CDocumentInfo {
        return CDocumentInfo(
            language: Int32(language.rawValue),
            role: documentRole == nil ? -1 : Int32(documentRole!.rawValue),
            country: country == nil ? -1 : Int32(country!.rawValue),
            code: code == nil ? -1 : Int32(code!.rawValue),
            page: page == nil ? -1 : Int32(page!.rawValue),
            state: -1,
            hologramState: -1,
            orientation: Int32(orientation.rawValue),
            signature: .init()
        )
    }

    private func createDocumentVerifierSettings(settings: DocumentVerifierSettings?) -> CDocumentVerifierSettings {
        return CDocumentVerifierSettings(
            timeToBlurMaxToleranceInSeconds: Int32(settings?.timeToBlurMaxToleranceInSeconds ?? 10),
            visualizerVersion: Int32(settings?.visualizerVersion ?? 1), showTimer: settings?.showTimer ?? false,
            enableAimingCircle: settings?.showAimingCircle ?? false,
            drawOutline: settings?.drawOutline ?? false
        )
    }

    public func getRequiredFPS() -> Int {
        let fps = RecogLib_iOS.getDocumentRequiredFps(cppObject)
        return Int(fps)
    }

    public func getRequiredResolution() -> Int {
        let resolution = RecogLib_iOS.getDocumentRequiredVideoResolution(cppObject)
        return Int(resolution)
    }

    /// After taking a picture and processing the corresponding side of the document with the MRZ zone, 
    /// it returns the code needed to enable communication with the NFC chip
    public func getNfcKey() -> String? {
        guard let mrzFields = getMrzFields() else { return nil }
        let code = NfcUtils.getMRZKey(documentNumber: mrzFields.DocumentNumber, dateOfBirth: mrzFields.BirthDate, dateOfExpiry: mrzFields.ExpiryDate)
        return code
    }
    
    /// After taking a picture and processing the corresponding side of the document with the MRZ zone,
    /// it returns a structure with the items needed to calculate the code required to enable communication with the NFC chip
    public func getMrzFields() -> MrzFields? {
        let code = RecogLib_iOS.getNfcKey(cppObject)
        defer { free(code) }
        if let unwrappedCode = code {
            let strJson = String(cString: unwrappedCode)
            guard let strData = strJson.data(using: .utf8) else { return nil }
            guard let decoded = try? JSONDecoder().decode(MrzFields.self, from: strData) else { return nil }
            return decoded
        }
        return nil
    }

    /// Sends the data read by NFC to the SDK for processing.
    ///   - jsonData: String  - The data is in JSON format.
    ///   The NfcData.encodeToJson() method must be used to ensure the correct format when encoding.
    ///   - status: NfcStatus - Result of NFC reading process
    public func processNfc(jsonData: String, status: NfcStatus) {
        var cStatus: CNfcStatus
        switch status {
        case .DEVICE_DOES_NOT_SUPPORT_NFC:
            cStatus = DeviceDoesNotSupportNfc
        case .INVALID_NFC_KEY:
            cStatus = InvalidNfcKey
        case .USER_SKIPPED:
            cStatus = UserSkipped
        case .OK:
            cStatus = Ok
        }
        RecogLib_iOS.processNfcResult(cppObject, jsonData.toUnsafeMutablePointer(), cStatus)
    }

    /// A method that returns the current state of the document being verified.
    /// It is usually called to check the status after sending NFC data for processing `verifier.processNfc(..)`
    public func getState() -> DocumentVerifierState? {
        let cState = RecogLib_iOS.getState(cppObject)
        let state = DocumentVerifierState(rawValue: Int(cState))
        return state
    }

    /// Returns the last processed image and its signature.
    /// Warning. ImageSignature  is returned only if processing is complete and the status is `.Ok` Otherwise returns nil.
    public func getSignedImage() -> ImageSignature? {
        let cSignature = RecogLib_iOS.getSignedImage(cppObject)
        let signature = DocumentSignatureMapper.map(cSignature)
        return signature
    }

    /// Returns the NFC validator settings read from the backend.
    public func getNfcValidatorSettings() -> DocumentVerifierNfcValidatorSettings {
        let cConfig = RecogLib_iOS.getSdkConfig(cppObject)

        return DocumentVerifierNfcValidatorSettings(
            numberOfReadingAttempts: Int(cConfig.numberOfReadingAttempts),
            skipNfcAllowed: cConfig.skipNfcAllowed,
            noNfcMeansError: cConfig.noNfcMeansError,
            isEnabled: cConfig.isEnabled,
            acceptScore: Int(cConfig.acceptScore),
            scoreStep: Int(cConfig.scoreStep),
            isTestEnabled: cConfig.isTestEnabled
        )
    }

    /// A method that returns the current result of the document being verified.
    /// It is usually called to check the status after sending NFC data for processing `verifier.processNfc(..)`
    public func getDocumentResult(orientation: UIInterfaceOrientation = .portrait) -> DocumentResult? {
        var document = createDocumentInfo(orientation: orientation)
        RecogLib_iOS.getDocumentResult(cppObject, &document)
        return DocumentResult(document: document)
    }
    
    /// A method that returns the current settings of the document verifier.
    public func getSettings() -> DocumentVerifierSettings {
        let csettings: CDocumentVerifierSettings = RecogLib_iOS.getDocumentSettings(cppObject);
        let settings: DocumentVerifierSettings = .init(
            timeToBlurMaxToleranceInSeconds: Int(csettings.timeToBlurMaxToleranceInSeconds),
            showTimer: csettings.showTimer,
            showAimingCircle: csettings.enableAimingCircle,
            drawOutline: csettings.drawOutline,
            visualizerVersion: Int(csettings.visualizerVersion)
        )
        return settings
    }

//    public func getImagePreview() -> Data? {
//        var preview = CPreviewData()
//        let _ = RecogLib_iOS.getImagePreview(cppObject, &preview)
//        if let image = preview.image {
//            return Data(bytes: image, count: Int(preview.imageSize))
//        }
//        return nil
//    }
}
