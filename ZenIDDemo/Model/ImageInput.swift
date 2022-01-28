//
//  ImageInput.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 22.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit.UIImage
import RecogLib_iOS

struct ImageInput {
    var imageData: Data
    var documentType: DocumentType
    var documentRole: RecogLib_iOS.DocumentRole?
    var documentCode: String
    var photoType: PhotoType
    var country: Country
    var signature: String?
    var dataType: DataType
}
