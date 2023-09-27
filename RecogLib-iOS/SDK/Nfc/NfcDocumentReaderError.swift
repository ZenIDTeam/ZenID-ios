 public enum NfcDocumentReaderError: Error, Equatable {
    case ResponseError(String, UInt8, UInt8)
    case InvalidResponse
    case UnexpectedError
    case NFCNotSupported
    case NoConnectedTag
    case D087Malformed
    case InvalidResponseChecksum
    case MissingMandatoryFields
    case CannotDecodeASN1Length
    case InvalidASN1Value
    case UnableToProtectAPDU
    case UnableToUnprotectAPDU
    case UnsupportedDataGroup
    case DataGroupNotRead
    case UnknownTag
    case UnknownImageFormat
    case NotImplemented
    case TagNotValid
    case ConnectionError
    case UserCanceled
    case InvalidMRZKey
    case MoreThanOneTagFound
    case InvalidHashAlgorithmSpecified
    case UnsupportedCipherAlgorithm
    case UnsupportedMappingType
    case PACEError(String, String)
    case ChipAuthenticationFailed
    case InvalidDataPassed(String)
    case NotYetSupported(String)
    case LostConnection

    var value: String {
        switch self {
        case let .ResponseError(errMsg, _, _): return errMsg
        case .InvalidResponse: return "InvalidResponse"
        case .UnexpectedError: return "UnexpectedError"
        case .NFCNotSupported: return "NFCNotSupported"
        case .NoConnectedTag: return "NoConnectedTag"
        case .D087Malformed: return "D087Malformed"
        case .InvalidResponseChecksum: return "InvalidResponseChecksum"
        case .MissingMandatoryFields: return "MissingMandatoryFields"
        case .CannotDecodeASN1Length: return "CannotDecodeASN1Length"
        case .InvalidASN1Value: return "InvalidASN1Value"
        case .UnableToProtectAPDU: return "UnableToProtectAPDU"
        case .UnableToUnprotectAPDU: return "UnableToUnprotectAPDU"
        case .UnsupportedDataGroup: return "UnsupportedDataGroup"
        case .DataGroupNotRead: return "DataGroupNotRead"
        case .UnknownTag: return "UnknownTag"
        case .UnknownImageFormat: return "UnknownImageFormat"
        case .NotImplemented: return "NotImplemented"
        case .TagNotValid: return "TagNotValid"
        case .ConnectionError: return "ConnectionError"
        case .UserCanceled: return "UserCanceled"
        case .InvalidMRZKey: return "InvalidMRZKey"
        case .MoreThanOneTagFound: return "MoreThanOneTagFound"
        case .InvalidHashAlgorithmSpecified: return "InvalidHashAlgorithmSpecified"
        case .UnsupportedCipherAlgorithm: return "UnsupportedCipherAlgorithm"
        case .UnsupportedMappingType: return "UnsupportedMappingType"
        case let .PACEError(step, reason): return "PACEError (\(step)) - \(reason)"
        case .ChipAuthenticationFailed: return "ChipAuthenticationFailed"
        case let .InvalidDataPassed(reason): return "Invalid data passed - \(reason)"
        case let .NotYetSupported(reason): return "Not yet supported - \(reason)"
        case .LostConnection: return "LostConnection"
        }
    }

    public static func == (lhs: NfcDocumentReaderError, rhs: NfcDocumentReaderError) -> Bool {
        switch (lhs, rhs) {
        case let (.ResponseError(lhsMessage, lhsCode1, lhsCode2), .ResponseError(rhsMessage, rhsCode1, rhsCode2)):
            return lhsMessage == rhsMessage && lhsCode1 == rhsCode1 && lhsCode2 == rhsCode2
        case (.InvalidResponse, .InvalidResponse):
            return true
        case (.UnexpectedError, .UnexpectedError):
            return true
        case (.NFCNotSupported, .NFCNotSupported):
            return true
        case (.NoConnectedTag, .NoConnectedTag):
            return true
        case (.D087Malformed, .D087Malformed):
            return true
        case (.InvalidResponseChecksum, .InvalidResponseChecksum):
            return true
        case (.MissingMandatoryFields, .MissingMandatoryFields):
            return true
        case (.CannotDecodeASN1Length, .CannotDecodeASN1Length):
            return true
        case (.InvalidASN1Value, .InvalidASN1Value):
            return true
        case (.UnableToProtectAPDU, .UnableToProtectAPDU):
            return true
        case (.UnableToUnprotectAPDU, .UnableToUnprotectAPDU):
            return true
        case (.UnsupportedDataGroup, .UnsupportedDataGroup):
            return true
        case (.DataGroupNotRead, .DataGroupNotRead):
            return true
        case (.UnknownTag, .UnknownTag):
            return true
        case (.UnknownImageFormat, .UnknownImageFormat):
            return true
        case (.NotImplemented, .NotImplemented):
            return true
        case (.TagNotValid, .TagNotValid):
            return true
        case (.ConnectionError, .ConnectionError):
            return true
        case (.UserCanceled, .UserCanceled):
            return true
        case (.InvalidMRZKey, .InvalidMRZKey):
            return true
        case (.MoreThanOneTagFound, .MoreThanOneTagFound):
            return true
        case (.InvalidHashAlgorithmSpecified, .InvalidHashAlgorithmSpecified):
            return true
        case (.UnsupportedCipherAlgorithm, .UnsupportedCipherAlgorithm):
            return true
        case (.UnsupportedMappingType, .UnsupportedMappingType):
            return true
        case let (.PACEError(lhsError1, lhsError2), .PACEError(rhsError1, rhsError2)):
            return lhsError1 == rhsError1 && lhsError2 == rhsError2
        case (.ChipAuthenticationFailed, .ChipAuthenticationFailed):
            return true
        case let (.InvalidDataPassed(lhsData), .InvalidDataPassed(rhsData)):
            return lhsData == rhsData
        case let (.NotYetSupported(lhsMessage), .NotYetSupported(rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
