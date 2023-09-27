//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//
class DataGroupParser {
    static let dataGroupNames = ["Common", "DG1", "DG2", "DG3", "DG4", "DG5", "DG6", "DG7", "DG8", "DG9", "DG10", "DG11", "DG12", "DG13", "DG14", "DG15", "DG16", "SecurityData"]
    static let tags: [UInt8] = [0x60, 0x61, 0x75, 0x63, 0x76, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x77]
    static let classes: [DataGroup.Type] = [COM.self, DataGroup1.self, DataGroup2.self,
                                            NotImplementedDG.self, NotImplementedDG.self, NotImplementedDG.self,
                                            NotImplementedDG.self, DataGroup7.self, NotImplementedDG.self,
                                            NotImplementedDG.self, NotImplementedDG.self, DataGroup11.self,
                                            DataGroup12.self, NotImplementedDG.self, DataGroup14.self,
                                            DataGroup15.self, NotImplementedDG.self, SOD.self]

    func parseDG(data: [UInt8]) throws -> DataGroup {
        let header = data[0 ..< 4]

        let dg = try tagToDG(header[0])

        return try dg.init(data)
    }

    func tagToDG(_ tag: UInt8) throws -> DataGroup.Type {
        guard let index = DataGroupParser.tags.firstIndex(of: tag) else { throw NfcDocumentReaderError.UnknownTag }
        return DataGroupParser.classes[index]
    }
}
