//
//  Document.swift
//  RecogLib-iOS
//
//  Created by Libor Polehna on 21.06.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import Foundation


public struct Document: Comparable {
    public static func < (lhs: Document, rhs: Document) -> Bool {
        lhs.role == rhs.role &&
            lhs.country == rhs.country &&
            lhs.page == rhs.page &&
            lhs.code == rhs.code
    }
    
    public let role: DocumentRole?
    public let country: Country?
    public let page: PageCode?
    public let code: DocumentCode?
    
    public init(role: DocumentRole?, country: Country?, page: PageCode?, code: DocumentCode?) {
        self.role = role
        self.country = country
        self.page = page
        self.code = code
    }
}
