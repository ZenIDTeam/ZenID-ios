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
    
    public func load(onLoad: (Data, String) -> Void) {
        load(url: url, onLoad: onLoad)
    }
    
    private func load(url: URL, onLoad: (Data, String) -> Void) {
        let contents = getContent(of: url)
        for content in contents {
            let fileUrl = url.appendingPathComponent(content)
            if isDirectory(url: fileUrl) {
                load(url: fileUrl, onLoad: onLoad)
            } else if isBinFile(url: fileUrl), notIQS(filename: content) {
                onLoad(loadData(url: fileUrl), fileUrl.lastPathComponent)
            }
        }
    }
    
    private func getContent(of url: URL) -> [String] {
        guard let contents = try? fileManager.contentsOfDirectory(atPath: url.path) else {
            return []
        }
        return contents
    }
    
    @inline(__always)
    private func isDirectory(url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        return fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
    }
    
    @inline(__always)
    private func notIQS(filename: String) -> Bool {
        !filename.hasPrefix("iqs_")
    }
    
    @inline(__always)
    private func isBinFile(url: URL) -> Bool {
        url.path.hasSuffix("bin")
    }
    
    private func loadData(url: URL) -> Data {
        (try? Data(contentsOf: url)) ?? Data()
    }
}
