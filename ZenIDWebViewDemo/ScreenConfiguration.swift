import Foundation

protocol JsonConvertible {
    func toJson() throws -> String
}

extension JsonConvertible where Self: Encodable {
    func toJson() throws -> String {
        let raw = try JSONEncoder().encode(self)
        guard let command = String(data: raw, encoding: .utf8) else {
            fatalError("Faield to encode JSON command")
        }
        return command
    }
}

struct DocumentScreenConfiguration: Encodable, JsonConvertible {
    struct Detail: Encodable {
        enum Role: String, Encodable {
            case Drv
            case Idc
            case Pas
            case Filter
        }

        enum Page: String, Encodable {
            case F
            case B
        }

        let feature: AppFeature = .document
        let role: Role
        let page: Page?
        let feedback: String? //    feedback: 'Blurry'
    }

    let detail: Detail

    init(role: Detail.Role, page: Detail.Page?, feedback: String?) {
        detail = Detail(role: role, page: page, feedback: feedback)
    }
    
    init(role: Detail.Role) {
        detail = Detail(role: role, page: nil, feedback: nil)
    }
}

struct ScreenConfiguration: Codable, JsonConvertible {
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
