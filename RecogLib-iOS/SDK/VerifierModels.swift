import Foundation

public protocol VerifierModels {
    var url: URL { get }
    
    func load(onLoad: (Data, String) -> Void)
}

extension VerifierModels {
    func loadPointer(onLoad: (UnsafePointer<CChar>, Data, String) -> Void) {
        load { data, modelName in
            guard let pointer = getPointer(data: data) else {
                return
            }
            onLoad(pointer, data, modelName)
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
