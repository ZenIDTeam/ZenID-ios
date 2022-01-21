//
//  MatcherResult.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 27/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation
import CoreGraphics
import AVFoundation
import UIKit

public struct DocumentResult {
    public var state: DocumentState
    public var role: DocumentRole?
    public var country: Country?
    public var code: DocumentCode?
    public var page: PageCode?
    public var hologremState: HologramState?
    
    public var signature: ImageSignature?
        
    init?(document: CDocumentInfo) {
        guard let state = DocumentState(rawValue: Int(document.state)) else { return nil }
                
        self.page = PageCode(rawValue: Int(document.page))
        self.role = DocumentRole(rawValue: Int(document.role))
        self.code = DocumentCode(rawValue: Int(document.code))
        self.country = Country(rawValue: Int(document.country))
        self.state = state
        self.hologremState = HologramState(rawValue: Int(document.hologramState))
        self.signature = DocumentSignatureMapper.map(document.signature)
    }
}
