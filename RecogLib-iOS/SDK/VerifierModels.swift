
import Foundation


public protocol VerifierModels {
    var url: URL { get }
    
    func load(onLoad: (Data) -> Void)
}

extension VerifierModels {
    func loadPointer(onLoad: (UnsafePointer<CChar>, Data) -> Void) {
        load { data in
            guard let pointer = getPointer(data: data) else {
                return
            }
            onLoad(pointer, data)
        }
    }
    
    private func getPointer(data: Data) -> UnsafePointer<CChar>? {
        data.withUnsafeBytes {
            guard let pointer = $0.bindMemory(to: CChar.self).baseAddress else {
                return nil
            }
            return pointer
        }
    }
}
