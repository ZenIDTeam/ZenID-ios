//
//  CameraViewControllerDelegate.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit
import AVFoundation
import RecogLib_iOS

public protocol CameraViewControllerDelegate: class {
    func didTakePhoto(_ imageData: Data?, type: PhotoType, result: DocumentResult?)
    func didTakeVideo(_ videoAsset: AVURLAsset?, type: PhotoType)
    func didFinishPDF()
}
