import Foundation
import CoreMedia

public class DocumentVerifier {
    private var cppObject: UnsafeRawPointer?
    
    public var documentRole: DocumentRole?
    public var country: Country?
    public var page: PageCode?
    public var code: DocumentCode?
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

    public init(role: DocumentRole?, country: Country?, page: PageCode?, code: DocumentCode?, language: SupportedLanguages, settings: DocumentVerifierSettings? = nil) {
        self.documentRole = role
        self.country = country
        self.page = page
        self.code = code
        self.language = language
        self.settings = settings
        
        var verifierSettings = createDocumentVerifierSettings(settings: settings)
        self.cppObject = getDocumentVerifier(&verifierSettings)
    }
    
    public init(input: DocumentsInput, language: SupportedLanguages, settings: DocumentVerifierSettings? = nil) {
        self.acceptableInputJson = input.acceptableInputJson()
        self.language = language
        self.settings = settings
        
        var verifierSettings = createDocumentVerifierSettings(settings: settings)
        self.cppObject = getDocumentVerifier(&verifierSettings)
    }
    
    public func loadModels(_ loader: DocumentVerifierModels) {
        loader.loadPointer { pointer, data in
            RecogLib_iOS.loadModel(self.cppObject, pointer, data.count)
            ApplicationLogger.shared.Info("Loaded model: \(loader.url.lastPathComponent)")
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
    
    /*public func verifyHologram(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> HologramResult? {
        do {
            var document = createDocumentInfo(orientation: orientation)
            RecogLib_iOS.verifyHologram(cppObject, buffer, &document)
            return HologramResult(document: document)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    public func verifyHologramImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> HologramResult? {
        do {
            var document = createDocumentInfo(orientation: orientation)
            RecogLib_iOS.verifyHologramImage(cppObject, imageBuffer, &document)
            return HologramResult(document: document)
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }*/
    
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
            specularAcceptableScore: Int32(settings?.specularAcceptableScore ?? 50),
            documentBlurAcceptableScore: Int32(settings?.documentBlurAcceptableScore ?? 50),
            timeToBlurMaxToleranceInSeconds: Int32(settings?.timeToBlurMaxToleranceInSeconds ?? 10),
            visualizerVersion: Int32(settings?.visualizerVersion ?? 1), showTimer: settings?.showTimer ?? false,
            enableAimingCircle: settings?.showAimingCircle ?? false,
            drawOutline: settings?.drawOutline ?? false,
            readBarcode: settings?.readBarcode ?? true
        )
    }
}
