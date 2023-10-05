//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//
import Foundation
import CoreNFC

public class BACHandler {
    let KENC : [UInt8] = [0,0,0,1]
    let KMAC : [UInt8] = [0,0,0,2]
    
    public var ksenc : [UInt8] = []
    public var ksmac : [UInt8] = []

    var rnd_icc : [UInt8] = []
    var rnd_ifd : [UInt8] = []
    public var kifd : [UInt8] = []
    
    var tagReader : TagReader?
    
    public init(tagReader: TagReader) {
        self.tagReader = tagReader
    }

    public func performBACAndGetSessionKeys( mrzKey : String ) async throws {
        guard let tagReader = self.tagReader else {
            throw NfcDocumentReaderError.NoConnectedTag
        }
        
        ApplicationLogger.shared.Debug( "BACHandler - deriving Document Basic Access Keys" )
        _ = try self.deriveDocumentBasicAccessKeys(mrz: mrzKey)
        
        // Make sure we clear secure messaging (could happen if we read an invalid DG or we hit a secure error
        tagReader.secureMessaging = nil
        
        // get Challenge
        ApplicationLogger.shared.Debug( "BACHandler - Getting initial challenge" )
        let response = try await tagReader.getChallenge()
    
        ApplicationLogger.shared.Verbose( "DATA - \(response.data)" )
        
        ApplicationLogger.shared.Debug( "BACHandler - Doing mutual authentication" )
        let cmd_data = self.authentication(rnd_icc: [UInt8](response.data))
        let maResponse = try await tagReader.doMutualAuthentication(cmdData: Data(cmd_data))
        ApplicationLogger.shared.Debug( "DATA - \(maResponse.data)" )
        guard maResponse.data.count > 0 else {
            throw NfcDocumentReaderError.InvalidMRZKey
        }
        
        let (KSenc, KSmac, ssc) = try self.sessionKeys(data: [UInt8](maResponse.data))
        tagReader.secureMessaging = SecureMessaging(ksenc: KSenc, ksmac: KSmac, ssc: ssc)
        ApplicationLogger.shared.Debug( "BACHandler - complete" )
    }


    func deriveDocumentBasicAccessKeys(mrz: String) throws -> ([UInt8], [UInt8]) {
        let kseed = generateInitialKseed(kmrz:mrz)
    
        ApplicationLogger.shared.Verbose("Calculate the Basic Access Keys (Kenc and Kmac) using TR-SAC 1.01, 4.2")
        let smskg = SecureMessagingSessionKeyGenerator()
        self.ksenc = try smskg.deriveKey(keySeed: kseed, mode: .ENC_MODE)
        self.ksmac = try smskg.deriveKey(keySeed: kseed, mode: .MAC_MODE)
                
        return (ksenc, ksmac)
    }
    
    ///
    /// Calculate the kseed from the kmrz:
    /// - Calculate a SHA-1 hash of the kmrz
    /// - Take the most significant 16 bytes to form the Kseed.
    /// @param kmrz: The MRZ information
    /// @type kmrz: a string
    /// @return: a 16 bytes string
    ///
    /// - Parameter kmrz: mrz key
    /// - Returns: first 16 bytes of the mrz SHA1 hash
    ///
    func generateInitialKseed(kmrz : String ) -> [UInt8] {
        
        ApplicationLogger.shared.Verbose("Calculate the SHA-1 hash of MRZ_information")
        ApplicationLogger.shared.Verbose("\tMRZ KEY - \(kmrz)")
        let hash = calcSHA1Hash( [UInt8](kmrz.data(using:.utf8)!) )
        
        ApplicationLogger.shared.Verbose("\tsha1(MRZ_information): \(binToHexRep(hash))")
        
        let subHash = Array(hash[0..<16])
        ApplicationLogger.shared.Verbose("Take the most significant 16 bytes to form the Kseed")
        ApplicationLogger.shared.Verbose("\tKseed: \(binToHexRep(subHash))" )
        
        return Array(subHash)
    }
    
    
    /// Construct the command data for the mutual authentication.
    /// - Request an 8 byte random number from the MRTD's chip (rnd.icc)
    /// - Generate an 8 byte random (rnd.ifd) and a 16 byte random (kifd)
    /// - Concatenate rnd.ifd, rnd.icc and kifd (s = rnd.ifd + rnd.icc + kifd)
    /// - Encrypt it with TDES and the Kenc key (eifd = TDES(s, Kenc))
    /// - Compute the MAC over eifd with TDES and the Kmax key (mifd = mac(pad(eifd))
    /// - Construct the APDU data for the mutualAuthenticate command (cmd_data = eifd + mifd)
    ///
    /// @param rnd_icc: The challenge received from the ICC.
    /// @type rnd_icc: A 8 bytes binary string
    /// @return: The APDU binary data for the mutual authenticate command
    func authentication( rnd_icc : [UInt8]) -> [UInt8] {
        self.rnd_icc = rnd_icc
        
        ApplicationLogger.shared.Verbose("Request an 8 byte random number from the MRTD's chip")
        ApplicationLogger.shared.Verbose("\tRND.ICC: " + binToHexRep(self.rnd_icc))
        
        self.rnd_icc = rnd_icc

        let rnd_ifd = generateRandomUInt8Array(8)
        let kifd = generateRandomUInt8Array(16)
        
        ApplicationLogger.shared.Verbose("Generate an 8 byte random and a 16 byte random")
        ApplicationLogger.shared.Verbose("\tRND.IFD: \(binToHexRep(rnd_ifd))" )
        ApplicationLogger.shared.Verbose("\tRND.Kifd: \(binToHexRep(kifd))")
        
        let s = rnd_ifd + rnd_icc + kifd
        
        ApplicationLogger.shared.Verbose("Concatenate RND.IFD, RND.ICC and Kifd")
        ApplicationLogger.shared.Verbose("\tS: \(binToHexRep(s))")
        
        let iv : [UInt8] = [0, 0, 0, 0, 0, 0, 0, 0]
        let eifd = tripleDESEncrypt(key: ksenc,message: s, iv: iv)
        
        ApplicationLogger.shared.Verbose("Encrypt S with TDES key Kenc as calculated in Appendix 5.2")
        ApplicationLogger.shared.Verbose("\tEifd: \(binToHexRep(eifd))")
        
        let mifd = mac(algoName: .DES, key: ksmac, msg: pad(eifd, blockSize:8))

        ApplicationLogger.shared.Verbose("Compute MAC over eifd with TDES key Kmac as calculated in-Appendix 5.2")
        ApplicationLogger.shared.Verbose("\tMifd: \(binToHexRep(mifd))")
        // Construct APDU
        
        let cmd_data = eifd + mifd
        ApplicationLogger.shared.Verbose("Construct command data for MUTUAL AUTHENTICATE")
        ApplicationLogger.shared.Verbose("\tcmd_data: \(binToHexRep(cmd_data))")
        
        self.rnd_ifd = rnd_ifd
        self.kifd = kifd

        return cmd_data
    }
    
    /// Calculate the session keys (KSenc, KSmac) and the SSC from the data
    /// received by the mutual authenticate command.
    
    /// @param data: the data received from the mutual authenticate command send to the chip.
    /// @type data: a binary string
    /// @return: A set of two 16 bytes keys (KSenc, KSmac) and the SSC
    public func sessionKeys(data : [UInt8] ) throws -> ([UInt8], [UInt8], [UInt8]) {
        ApplicationLogger.shared.Verbose("Decrypt and verify received data and compare received RND.IFD with generated RND.IFD \(binToHexRep(self.ksmac))" )
        
        let response = tripleDESDecrypt(key: self.ksenc, message: [UInt8](data[0..<32]), iv: [0,0,0,0,0,0,0,0] )

        let response_kicc = [UInt8](response[16..<32])
        let Kseed = xor(self.kifd, response_kicc)
        ApplicationLogger.shared.Verbose("Calculate XOR of Kifd and Kicc")
        ApplicationLogger.shared.Verbose("\tKseed: \(binToHexRep(Kseed))" )
        
        let smskg = SecureMessagingSessionKeyGenerator()
        let KSenc = try smskg.deriveKey(keySeed: Kseed, mode: .ENC_MODE)
        let KSmac = try smskg.deriveKey(keySeed: Kseed, mode: .MAC_MODE)

//        let KSenc = self.keyDerivation(kseed: Kseed,c: KENC)
//        let KSmac = self.keyDerivation(kseed: Kseed,c: KMAC)
        
        ApplicationLogger.shared.Verbose("Calculate Session Keys (KSenc and KSmac) using Appendix 5.1")
        ApplicationLogger.shared.Verbose("\tKSenc: \(binToHexRep(KSenc))" )
        ApplicationLogger.shared.Verbose("\tKSmac: \(binToHexRep(KSmac))" )
        
        
        let ssc = [UInt8](self.rnd_icc.suffix(4) + self.rnd_ifd.suffix(4))
        ApplicationLogger.shared.Verbose("Calculate Send Sequence Counter")
        ApplicationLogger.shared.Verbose("\tSSC: \(binToHexRep(ssc))" )
        return (KSenc, KSmac, ssc)
    }
    
}
