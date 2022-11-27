//
//  Defaults.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 21.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import AVFoundation
import RecogLib_iOS
import UIKit

public final class Defaults {
    private static let defaults: UserDefaults = {
        let defaults = UserDefaults.standard

        let localDefaults = Bundle.main.path(forResource: "Settings", ofType: "plist")
        if let localDefaultsDictionary = NSDictionary(contentsOfFile: localDefaults!) as? Dictionary<String, AnyObject> {
            defaults.setValuesForKeys(localDefaultsDictionary)
            defaults.synchronize()
        }

        let appDefaults = [String: AnyObject]()
        defaults.register(defaults: appDefaults)
        defaults.synchronize()

        return defaults
    }()

    public static var firstRun: Bool {
        get { return defaults[#function] ?? true }
        set { defaults[#function] = newValue }
    }

    public static var selectedCountry: Country {
        get {
            let rawValue = defaults[#function] ?? Country.Cz.rawValue
            return Country(rawValue: rawValue) ?? Country.Cz
        }
        set { defaults[#function] = newValue.rawValue }
    }

    public static var selectedFaceMode: FaceMode? {
        get {
            let rawValue: String? = defaults[#function]
            if let value = rawValue {
                return FaceMode(rawValue: value)
            }
            return nil
        }
        set { defaults[#function] = newValue?.rawValue }
    }

    @available(macCatalyst 14.0, *)
    public static var torchMode: AVCaptureDevice.TorchMode {
        let rawValue = defaults[#function] ?? "On"
        switch rawValue {
        case "On": return .on
        case "Auto": return .auto
        default: return .on
        }
    }

    public static var credentialsSettings: CredentialsSettings {
        get {
            if let encodedData = defaults.data(forKey: #function) {
                let result = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData)
                let obj = result as? CredentialsSettings
                return obj ?? CredentialsSettings()
            } else {
                return CredentialsSettings()
            }
        }
        set {
            let encodedData: Data? = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false)
            defaults.set(encodedData, forKey: #function)
            defaults.synchronize()
        }
    }
}
