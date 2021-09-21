
import Foundation


public final class DocumentVerifierModels: VerifierModels {
    public let url: URL
    private let fileManager: FileManager
    
    public init?(url: URL, fileManager: FileManager = .default) {
        var isDirectory: ObjCBool = false
        let fileExists = fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
        if !(isDirectory.boolValue && fileExists) {
            return nil
        }
        self.url = url
        self.fileManager = fileManager
    }
    
    public func load(onLoad: (Data) -> Void) {
        guard let contents = try? fileManager.contentsOfDirectory(atPath: url.path) else {
            return
        }
        contents
            .filter { $0.hasSuffix("bin") }
            .sorted()
            .map(url.appendingPathComponent)
            .forEach { url in
                onLoad(loadData(url: url))
            }
    }
    
    private func loadData(url: URL) -> Data {
        (try? Data(contentsOf: url)) ?? Data()
    }
}
