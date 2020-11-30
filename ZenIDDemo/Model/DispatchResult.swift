//
//  DispatchResult.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 20/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation

enum DispatchResult {
    case completed(sampleID: String?)
    case rescan(photoType: PhotoType, error: DispatchError?)
}
