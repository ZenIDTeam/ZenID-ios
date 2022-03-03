//
//  VideoWriterDelegate.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 05/07/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import AVFoundation

public protocol VideoWriterDelegate: AnyObject {
    func didTakeVideo(_ videoAsset: AVURLAsset)
}
