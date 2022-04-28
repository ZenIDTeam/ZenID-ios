import Foundation

public struct HologramResult {
    public var hologramState: HologramState
    
    init?(document: CDocumentInfo) {
        guard let hologramState = HologramState(rawValue: Int(document.hologramState)) else {
            return nil
        }
        self.hologramState = hologramState
    }
}
