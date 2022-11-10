import AVFoundation
import CoreGraphics
import Foundation
import UIKit

public struct DocumentResult {
    public var state: DocumentState
    public var role: DocumentRole?
    public var country: Country?
    public var code: DocumentCode?
    public var page: PageCode?
    public var hologremState: HologramState?

    public var signature: ImageSignature?

    init?(document: CDocumentInfo) {
        guard let state = DocumentState(rawValue: Int(document.state)) else { return nil }

        page = PageCode(rawValue: Int(document.page))
        role = DocumentRole(rawValue: Int(document.role))
        code = DocumentCode(rawValue: Int(document.code))
        country = Country(rawValue: Int(document.country))
        self.state = state
        hologremState = HologramState(rawValue: Int(document.hologramState))
        signature = DocumentSignatureMapper.map(document.signature)
    }
}
