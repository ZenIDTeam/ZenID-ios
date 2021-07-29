
import Foundation


final class DocumentSignatureMapper {
    
    static func map(_ cSignature: CImageSignature?) -> ImageSignature? {
        guard let cSignature = cSignature else {
            return nil
        }
        if let image = cSignature.image, let signature = cSignature.signature {
            let data = Data(bytes: image, count: Int(cSignature.imageSize))
            return .init(
                image: data,
                signature: String(cString: UnsafePointer<CChar>(signature))
            )
        }
        return nil
    }
    
}
