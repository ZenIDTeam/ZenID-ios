//
//  Source taken or based on NFCPassportReader project
//  https://github.com/AndyQ/NFCPassportReader
//  Created by Andy Qua on 25/02/2021.
//

public struct ResponseAPDU {
    public var data: [UInt8]
    public var sw1: UInt8
    public var sw2: UInt8

    public init(data: [UInt8], sw1: UInt8, sw2: UInt8) {
        self.data = data
        self.sw1 = sw1
        self.sw2 = sw2
    }
}
