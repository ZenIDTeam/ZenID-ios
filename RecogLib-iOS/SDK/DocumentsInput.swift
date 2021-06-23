//
//  DocumentsInput.swift
//  RecogLib-iOS
//
//  Created by Libor Polehna on 21.06.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import Foundation


public class DocumentsInput {
    
    private let documents: [Document]
    
    public init(documents: [Document]) {
        self.documents = documents
    }
    
    internal func acceptableInputJson() -> String {
        let jsonString = "{\"PossibleDocuments\":[\(map(documents: documents))]}"
        print(jsonString)
        return jsonString
    }
    
    private func map(documents: [Document]) -> String {
        documents.map { document in
            map(document: document)
        }.joined(separator: ",")
    }
    
    private func map(document: Document) -> String {
        var attributeStrings = [String]()
        if let role = document.role {
            attributeStrings.append("\"Role\": \"\(role.description)\"")
        }
        if let country = document.country {
            attributeStrings.append("\"Country\": \"\(country.description)\"")
        }
        if let page = document.page {
            attributeStrings.append("\"Page\": \"\(page.description)\"")
        }
        if let code = document.code {
            attributeStrings.append("\"Code\": \"\(code.description)\"")
        }
        let documentJSONString = attributeStrings.joined(separator: ",")
        return "{" + documentJSONString + "}"
    }
    
}
