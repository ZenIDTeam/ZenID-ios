public enum AuthenticationStatus {
    case notDone
    case success
    case failed
}

public protocol NFCDocumentModelType {
    
    var activeAuthenticationPassed: Bool { get }
    
    var BACAuthStatus: AuthenticationStatus { get }
    
    var isPACESupported: Bool { get }
    
    var PACEAuthStatus: AuthenticationStatus { get }
    
    var passportCorrectlySigned: Bool { get }
    
    var documentSigningCertificateVerified: Bool { get }
    
    var passportDataNotTampered: Bool { get }
    
    var passportMRZ: String { get }
    
    var passportImage: UIImage? { get }
    
    var signatureImage: UIImage? { get }
    
    var firstName: String { get }
    
    var lastName: String { get }
    
    var nationality: String { get }
    
    var gender: String { get }
    
    var dateOfBirth: String { get }
    
    var personalNumber: String? { get }
    
    var documentExpiryDate: String { get }
    
    var documentNumber: String { get }
    
    var documentType: String { get }
    
    var documentSubType: String { get }
    
    var issuingAuthority: String { get }
    
    var LDSVersion: String { get }
    
    var dataGroupsPresent: [String] { get }
    
    var dataGroupsAvailable: [DataGroupId] { get }

    func getDataGroupData(_ groupId: DataGroupId) -> [UInt8]?
    
    func getEncodedDataGroup(_ groupId: DataGroupId) -> String?
}
