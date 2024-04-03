import Foundation

public struct NfcData {
    
    public let DataGroups: [DataGroupId: String]
    
    public let ProtocolUsed: NfcProtocol
    
    public let document: NFCDocumentModelType?

    public init(document: NFCDocumentModelType) {
        self.document = document
        let pac = document.PACEAuthStatus

        if case .success = pac {
            ProtocolUsed = .PACE
        } else {
            ProtocolUsed = .BAC
        }
        var dataGroups: [DataGroupId: String] = [:]

        if let com = document.getEncodedDataGroup(.COM) {
            dataGroups[.COM] = com
        }

        for id in DataGroupId.allCases {
            if id == .Unknown { continue }
            ApplicationLogger.shared.Debug("[NfcData] Reading section \(id)")
            if let encodedData = document.getEncodedDataGroup(id) {
                dataGroups[id] = encodedData
                ApplicationLogger.shared.Debug("[NfcData] Data: \(encodedData)")
            }
        }

        DataGroups = dataGroups
    }
}

extension NfcData: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case DataGroups
        case ProtocolUsed
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let strDict = Dictionary(
            uniqueKeysWithValues: DataGroups.map({ key, value in
                (String(describing: key), value)
            })
        )
        try? container.encode(strDict, forKey: .DataGroups)
        try? container.encode(ProtocolUsed, forKey: .ProtocolUsed)
    }

    func encodeToJson() -> String? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            ApplicationLogger.shared.Debug("❌ Failed to encode NfcData to JSON")
            return nil
        }
        guard let jsonString = String(data: data, encoding: .utf8) else {
            ApplicationLogger.shared.Debug("❌ Failed to create NfcData JSON string")
            return nil
        }
        return jsonString
    }
}
@available(iOS 13.0.0, *)
extension DataGroup {
    
    func getContentEncoded() -> String {
        let data = Data(data)
        let encoded = data.base64EncodedString()
        return encoded
    }
}

extension NfcData {
    
    public enum NfcProtocol: Int, Encodable {
        case PACE
        case BAC
    }
}

extension NfcData {
    
    public enum DGName: Int, CaseIterable {
        case COM = 0
        case SOD = 1
        case DG1 = 2
        case DG2 = 3
        case DG3 = 4
        case DG4 = 5
        case DG5 = 6
        case DG6 = 7
        case DG7 = 8
        case DG8 = 9
        case DG9 = 10
        case DG10 = 11
        case DG11 = 12
        case DG12 = 13
        case DG13 = 14
        case DG14 = 15
        case DG15 = 16
        case DG16 = 17
        case UNKNOWN = -1
        
        public func getName() -> String {
            String(describing: self)
        }
    }
}

extension NfcData.DGName {
    
    init(from external: DataGroupId) {
        switch external {
        case .COM:
            self = .COM
        case .SOD:
            self = .SOD
        case .DG1:
            self = .DG1
        case .DG2:
            self = .DG2
        case .DG3:
            self = .DG3
        case .DG4:
            self = .DG4
        case .DG5:
            self = .DG5
        case .DG6:
            self = .DG6
        case .DG7:
            self = .DG7
        case .DG8:
            self = .DG8
        case .DG9:
            self = .DG9
        case .DG10:
            self = .DG10
        case .DG11:
            self = .DG11
        case .DG12:
            self = .DG12
        case .DG13:
            self = .DG13
        case .DG14:
            self = .DG14
        case .DG15:
            self = .DG15
        case .DG16:
            self = .DG16
        case .Unknown:
            self = .UNKNOWN
        }
    }

    var toDataGroupId: DataGroupId {
        switch self {
        case .COM:
            return .COM
        case .SOD:
            return .SOD
        case .DG1:
            return .DG1
        case .DG2:
            return .DG2
        case .DG3:
            return .DG3
        case .DG4:
            return .DG4
        case .DG5:
            return .DG5
        case .DG6:
            return .DG6
        case .DG7:
            return .DG7
        case .DG8:
            return .DG8
        case .DG9:
            return .DG9
        case .DG10:
            return .DG10
        case .DG11:
            return .DG11
        case .DG12:
            return .DG12
        case .DG13:
            return .DG13
        case .DG14:
            return .DG14
        case .DG15:
            return .DG15
        case .DG16:
            return .DG16
        case .UNKNOWN:
            return .Unknown
        }
    }
}

extension NfcData.DGName: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(describing: self))
    }
}
