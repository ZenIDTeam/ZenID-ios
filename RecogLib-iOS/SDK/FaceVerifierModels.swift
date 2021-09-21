
import Foundation


public final class FaceVerifierModels: VerifierModels {
    public let url: URL
    private let fileManager: FileManager
    
    init?(url: URL, fileManager: FileManager = .default) {
        let fileExists = fileManager.fileExists(atPath: url.path)
        if !fileExists {
            return nil
        }
        self.url = url
        self.fileManager = fileManager
    }
    
    public func load(onLoad: (Data) -> Void) {
        onLoad(loadData(url: url))
    }
    
    private func loadData(url: URL) -> Data {
        (try? Data(contentsOf: url)) ?? Data()
    }
}
