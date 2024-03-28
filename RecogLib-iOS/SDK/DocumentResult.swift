import Foundation
import CoreGraphics
import AVFoundation
import UIKit

public struct DocumentResult {
    
    public var state: DocumentVerifierState
    
    public var role: DocumentRole?
    
    public var country: Country?
    
    public var code: DocumentCodes?
    
    public var page: PageCodes?
    
    public var hologramState: HologramState?
    
    public var signature: ImageSignature?
        
    init?(document: CDocumentInfo) {
        guard let state = DocumentVerifierState(rawValue: Int(document.state)) else { return nil }
                
        self.page = PageCodes(rawValue: Int(document.page))
        self.role = DocumentRole(rawValue: Int(document.role))
        self.code = DocumentCodes(rawValue: Int(document.code))
        self.country = Country(rawValue: Int(document.country))
        self.state = state
        self.hologramState = HologramState(rawValue: Int(document.hologramState))
        self.signature = DocumentSignatureMapper.map(document.signature)
    }
}

extension DocumentResult {
    init(signature: ImageSignature, state: DocumentVerifierState) {
        self.signature = signature
        self.state = state
    }
}
