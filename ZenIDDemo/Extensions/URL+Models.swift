
import Foundation


extension URL {
    static let modelsFolder = Bundle.main.bundleURL.appendingPathComponent("Models")
    static let modelsDocuments = modelsFolder.appendingPathComponent("documents")
    static let mrzModelsDocuments = modelsFolder.appendingPathComponent("mrz")
}
