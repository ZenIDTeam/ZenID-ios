import Foundation
import CoreMedia

public class FaceLivenessVerifier {
    private var cppObject: UnsafeRawPointer?

    public var language: SupportedLanguages
    private let settings: FaceLivenessVerifierSettings?
    
    public var showDebugInfo: Bool = false {
        didSet {
            setFaceLivenessDebugInfo(cppObject, showDebugInfo)
        }
    }
        
    public init(language: SupportedLanguages, settings: FaceLivenessVerifierSettings? = nil) {
        self.language = language
        self.settings = settings
    }
    
    public func loadModels(_ loader: FaceVerifierModels) {
        loader.loadPointer { pointer, data in
            var verifierSettings = createVerifierSettings(settings: settings)
            cppObject = RecogLib_iOS.getFaceLivenessVerifier(loader.url.path.toUnsafeMutablePointer()!, &verifierSettings)
        }
    }
    
    public func verify(buffer: CMSampleBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceLivenessResult? {
        var face = createFaceLivenessInfo(orientation: orientation)
        RecogLib_iOS.verifyFaceLiveness(cppObject, buffer, &face)
        return FaceLivenessResult(faceLivenessState: face.state, signature: face.signature)
    }
    
    public func verifyImage(imageBuffer: CVPixelBuffer, orientation: UIInterfaceOrientation = .portrait) -> FaceLivenessResult? {
        var face = createFaceLivenessInfo(orientation: orientation)
        RecogLib_iOS.verifyFaceLivenessImage(cppObject, imageBuffer, &face)
        return FaceLivenessResult(faceLivenessState: face.state, signature: face.signature)
    }
    
    public func update(settings: FaceLivenessVerifierSettings) {
        var settings = createVerifierSettings(settings: settings)
        updateFacelivenessVerifierSettings(cppObject, &settings)
    }
    
    public func getAuxiliaryInfo() -> FaceLivenessAuxiliaryInfo? {
        let cInfo = RecogLib_iOS.getAuxiliaryInfo(cppObject)
        let info = createFaceLivenessAuxiliaryInfo(info: cInfo)
        print(info.metadata)
        if info.images.isEmpty {
            return nil
        }
        return info
    }
    
    public func reset() {
        RecogLib_iOS.faceLivenessVerifierReset(cppObject)
    }
    
    public func getRenderCommands(canvasWidth: Int, canvasHeight: Int, orientation: UIInterfaceOrientation = .portrait) -> String? {
        var face = createFaceLivenessInfo(orientation: orientation)
        let cString = RecogLib_iOS.getFaceLivenessRenderCommands(cppObject, Int32(canvasWidth), Int32(canvasHeight), &face)
        defer { free(cString) }
        
        var result: String?
        if let unwrappedCString = cString {
            result = String(cString: unwrappedCString)
        }
        
        return result
    }
    
    private func createFaceLivenessInfo(orientation: UIInterfaceOrientation) -> CFaceLivenessInfo {
        return CFaceLivenessInfo(
            state: -1,
            orientation: Int32(orientation.rawValue),
            language: Int32(language.rawValue),
            signature: .init()
        )
    }
    
    private func createVerifierSettings(settings: FaceLivenessVerifierSettings?) -> CFaceLivenessVerifierSettings {
        return CFaceLivenessVerifierSettings(
            enableLegacyMode: settings?.isLegacyModeEnabled ?? false,
            maxAuxiliaryImageSize: Int32(settings?.maxAuxiliaryImageSize ?? 300),
            visualizerVersion: Int32(settings?.visualizerVersion ?? 1)
        )
    }
    
    private func createFaceLivenessAuxiliaryInfo(info: CFaceLivenessAuxiliaryInfo) -> FaceLivenessAuxiliaryInfo {
        var images = [Data]()
        var metadata = [FaceLivenessAuxiliaryMetadata]()
        if let cImages = info.images, let cImageLengths = info.imageLengths, let cMetadata = info.metadata {
            let imagesData = Data(bytes: cImages, count: Int(info.imagesSize))
            let lengths = UnsafeBufferPointer(start: cImageLengths, count: Int(info.imageLengthsSize))
            
            var currentPosition = 0
            for length in lengths {
                let image = imagesData.subdata(in: currentPosition ..< currentPosition + Int(length))
                currentPosition += Int(length)
                images.append(image)
            }
            
            let metadataString = String(cString: UnsafePointer<CChar>(cMetadata))
            let metadataData = metadataString.data(using: .utf8) ?? Data()
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            if let decodedMetadata = try? decoder.decode([FaceLivenessAuxiliaryMetadata].self, from: metadataData) {
                metadata.append(contentsOf: decodedMetadata)
            }
            cImages.deallocate()
            cImageLengths.deallocate()
            cMetadata.deallocate()
        }
        return .init(
            images: images,
            metadata: metadata
        )
    }
}
