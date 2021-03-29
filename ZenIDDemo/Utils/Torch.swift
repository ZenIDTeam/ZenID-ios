//
//  Torch.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 19/07/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import AVFoundation
import RecogLib_iOS

final class Torch {
    public static let shared = Torch()
    
    private let torchQueue = DispatchQueue(label: "cz.trask.ZenID.torch")
    
    private init() {
    }
    
    public func ensureMode(for device: AVCaptureDevice, on: Bool) {
        torchQueue.async { [weak device] in
            guard let device = device, device.hasTorch else { return }
            guard on || device.torchMode != .off else { return }
            
            let torchSettingsModeOn = Defaults.torchMode
            let torchMode: AVCaptureDevice.TorchMode = on ? torchSettingsModeOn : .off
            guard device.torchMode != torchMode else { return }
            
            if device.hasTorch {
                do {
                    try device.lockForConfiguration()
                } catch {
                    Log.shared.Verbose("\(device.localizedName) has no torch")
                }
                
                if torchMode == .off {
                    device.torchMode = .off
                } else {
                    device.torchMode = torchMode
                }
            }
            device.unlockForConfiguration()
        }
    }
}
