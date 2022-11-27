import Foundation

struct ScreenConfiguration: Codable {
    struct Detail: Codable {
        let feature: String
    }

    let detail: Detail

    init(feature: AppFeature) {
        detail = Detail(feature: feature.rawValue)
    }


    func toJson() throws -> String {
        let raw = try JSONEncoder().encode(self)
        guard let command = String(data: raw, encoding: .utf8) else {
            fatalError("Faield to encode JSON command")
        }
        return command
    }
}
