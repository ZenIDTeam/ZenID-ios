import Foundation
import RecogLib_iOS

struct UserDefaultsDocument: Codable {
    let role: Int?
    let country: Int?
    let page: Int?
    let code: Int?
    
    init(document: Document) {
        role = document.role?.rawValue
        country = document.country?.rawValue
        page = document.page?.rawValue
        code = document.code?.rawValue
    }
    
    func toDomain() -> Document {
        .init(
            role: role == nil ? nil : RecogLib_iOS.DocumentRole(rawValue: role!),
            country: country == nil ? nil : RecogLib_iOS.Country(rawValue: country!),
            page: page == nil ? nil : RecogLib_iOS.PageCodes(rawValue: page!),
            code: code == nil ? nil : RecogLib_iOS.DocumentCodes(rawValue: code!)
        )
    }
}

final class UserDefaultsDocumentsFilter {
    private static let key = "Documents"
    
    private let userDefaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
}

extension UserDefaultsDocumentsFilter: DocumentsFilterLoader {
    func load() throws -> [Document] {
        guard let data = userDefaults.data(forKey: Self.key) else {
            return getDefaultDocuments()
        }
        do {
            let userDefaultsDocuments = try decoder.decode([UserDefaultsDocument].self, from: data)
            return userDefaultsDocuments.map({ $0.toDomain() })
        } catch {
            return getDefaultDocuments()
        }
    }
    
    private func getDefaultDocuments() -> [Document] {
        []
    }
}

extension UserDefaultsDocumentsFilter: DocumentsFilterDeleter {
    func delete(document: Document) throws {
        var documents = try load()
        if let index = documents.firstIndex(of: document) {
            documents.remove(at: index)
            try save(documents: documents)
        }
    }
}

extension UserDefaultsDocumentsFilter: DocumentsFilterSaver {
    func save(document: Document) throws {
        let documents = try load() + [document]
        try save(documents: documents)
    }
    
    private func save(documents: [Document]) throws {
        let userDefaultsDocuments = documents.map({ UserDefaultsDocument(document: $0) })
        let data = try encoder.encode(userDefaultsDocuments)
        userDefaults.set(data, forKey: Self.key)
    }
}
