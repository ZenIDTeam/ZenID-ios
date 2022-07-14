
import Foundation


extension URL {
#if targetEnvironment(macCatalyst)
    static let modelsFolder = Bundle.main.bundleURL.appendingPathComponent("Contents/Resources/Models")
#else
    static let modelsFolder = Bundle.main.bundleURL.appendingPathComponent("Models")
#endif
    static let modelsDocuments = modelsFolder.appendingPathComponent("documents")
}
