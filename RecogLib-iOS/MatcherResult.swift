//
//  MatcherResult.swift
//  RecogLib-iOS
//
//  Created by Adam Salih on 27/06/2019.
//  Copyright © 2019 Marek Stana. All rights reserved.
//

import Foundation

public struct MatcherResult {
    public var role: DocumentRole
    public var country: Country
    public var code: DocumentCode?
    public var page: PageCode
    public var state: DocumentState
    
    init?(document: CDocumentInfo) {
        guard let role = DocumentRole(rawValue: Int(document.role)),
            let country = Country(rawValue: Int(document.country)),
            let page = PageCode(rawValue: Int(document.page)),
            let state = DocumentState(rawValue: Int(document.state)) else {
            return nil
        }
        self.page = page
        self.role = role
        self.code = DocumentCode(rawValue: Int(document.code))
        self.country = country
        self.state = state
    }
}
