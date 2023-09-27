//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//

import Foundation

public enum OpenSSLError: Error {
    case UnableToGetX509CertificateFromPKCS7(String)
    case UnableToVerifyX509CertificateForSOD(String)
    case VerifyAndReturnSODEncapsulatedData(String)
    case UnableToReadECPublicKey(String)
    case UnableToExtractSignedDataFromPKCS7(String)
    case VerifySignedAttributes(String)
    case UnableToParseASN1(String)
    case UnableToDecryptRSASignature(String)
}

extension OpenSSLError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .UnableToGetX509CertificateFromPKCS7(reason):
            return NSLocalizedString("Unable to read the SOD PKCS7 Certificate. \(reason)", comment: "UnableToGetPKCS7CertificateForSOD")
        case let .UnableToVerifyX509CertificateForSOD(reason):
            return NSLocalizedString("Unable to verify the SOD X509 certificate. \(reason)", comment: "UnableToVerifyX509CertificateForSOD")
        case let .VerifyAndReturnSODEncapsulatedData(reason):
            return NSLocalizedString("Unable to verify the SOD Datagroup hashes. \(reason)", comment: "UnableToGetSignedDataFromPKCS7")
        case let .UnableToReadECPublicKey(reason):
            return NSLocalizedString("Unable to read ECDSA Public key  \(reason)!", comment: "UnableToReadECPublicKey")
        case let .UnableToExtractSignedDataFromPKCS7(reason):
            return NSLocalizedString("Unable to extract Signer data from PKCS7  \(reason)!", comment: "UnableToExtractSignedDataFromPKCS7")
        case let .VerifySignedAttributes(reason):
            return NSLocalizedString("Unable to Verify the SOD SignedAttributes  \(reason)!", comment: "UnableToExtractSignedDataFromPKCS7")
        case let .UnableToParseASN1(reason):
            return NSLocalizedString("Unable to parse ASN1  \(reason)!", comment: "UnableToParseASN1")
        case let .UnableToDecryptRSASignature(reason):
            return NSLocalizedString("DatUnable to decrypt RSA Signature \(reason)!", comment: "UnableToDecryptRSSignature")
        }
    }
}

public enum PassiveAuthenticationError: Error {
    case UnableToParseSODHashes(String)
    case InvalidDataGroupHash(String)
    case SODMissing(String)
}

extension PassiveAuthenticationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .UnableToParseSODHashes(reason):
            return NSLocalizedString("Unable to parse the SOD Datagroup hashes. \(reason)", comment: "UnableToParseSODHashes")
        case let .InvalidDataGroupHash(reason):
            return NSLocalizedString("DataGroup hash not present or didn't match  \(reason)!", comment: "InvalidDataGroupHash")
        case let .SODMissing(reason):
            return NSLocalizedString("DataGroup SOD not present or not read  \(reason)!", comment: "SODMissing")
        }
    }
}
