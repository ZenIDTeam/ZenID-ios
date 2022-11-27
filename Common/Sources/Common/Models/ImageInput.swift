//
//  ImageInput.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 22.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import RecogLib_iOS
import UIKit.UIImage

public struct ImageInput {
    public var imageData: Data
    public var documentType: DocumentType
    public var documentRole: RecogLib_iOS.DocumentRole?
    public var documentCode: String
    public var photoType: PhotoType
    public var country: Country
    public var signature: String?
    public var dataType: DataType

    public init(imageData: Data, documentType: DocumentType, documentRole: RecogLib_iOS.DocumentRole? = nil, documentCode: String, photoType: PhotoType, country: Country, signature: String? = nil, dataType: DataType) {
        self.imageData = imageData
        self.documentType = documentType
        self.documentRole = documentRole
        self.documentCode = documentCode
        self.photoType = photoType
        self.country = country
        self.signature = signature
        self.dataType = dataType
    }
}
