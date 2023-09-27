/// Fields extracted by SDK from MRZ zone of the document
///   - DocumentNumber: The document number.
///   - BirthDate: The date of birth of the holder in YYMMDD format.
///   - ExpiryDate: The date of document expiry in YYMMDD format.
public struct MrzFields: Decodable {
    public let BirthDate: String
    public let DocumentNumber: String
    public let ExpiryDate: String
}
