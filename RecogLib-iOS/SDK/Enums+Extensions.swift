import Foundation

public extension DocumentCodes {
    init?(stringValue: String) {
        for code in DocumentCodes.allCases {
            if code.description.uppercased() == stringValue.uppercased() {
                self = code
                return
            }
        }
        return nil
    }
}

extension DocumentCodes {
    public var description: String {
        return String(describing: self).uppercased()
    }
}


extension PageCodes {
    public var description: String {
        return String(describing: self).uppercased()
    }
}

extension Country {
    public var description: String {
        return String(describing: self)
    }
}

extension DocumentRole {
    // Changed  Card -> Car
    // case .Car: return "Card"
    public var description: String {
        return String(describing: self)
    }
    
    public var descriptionOld: String {
        return switch self {
        case .Idc: "Idc"
        case .Drv: "Drv"
        case .Pas: "Pas"
        case .Res: "Res"
        case .Gun: "Gun"
        case .Hic: "Hic"
        case .Std: "Std"
        case .Car: "Car"
        case .Birth: "Birth"
        case .Add: "Add"
        case .Ide: "Ide"
        case .Vis: "Vis"
        case .Exp: "Exp"
        }
    }
}

extension SupportedLanguages {
    public var description: String {
        return switch self {
        case .Czech: "Cs"
        case .English: "En"
        case .Polish: "Pl"
        case .German: "De"
        }
    }
}

extension DocumentVerifierState {
    public var description: String {
        return switch self {
        case .NoMatchFound: "No match found"
        case .AlignCard: "Align card"
        case .HoldSteady: "Hold steady"
        case .Blurry: "Blurry"
        case .ReflectionPresent: "Reflection present"
        case .Ok: "Ok"
        case .Hologram: "Hologram error"
        case .Dark: "Too dark"
        case .Barcode: "Barcode not readable"
        case .TextNotReadable: "TextNotReadable"
        case .Nfc: "Nfc"
        }
    }
}

extension HologramState {
    public var description: String {
        return switch self {
        case .Center: "Center"
        case .TiltLeftAndRight: "Tilt left and right"
        case .TiltUpAndDown: "Tilt up and down"
        case .Ok: "Ok"
        case .TimedOut: "Timed out"
        case .TiltLeft: "Tilt left"
        case .TiltRight: "Tilt right"
        case .TiltUp: "Tilt up"
        case .TiltDown: "Tilt down"
        }
    }
}

extension FaceLivenessVerifierState {
    public var description: String {
        return switch self {
        case .LookAtMe: "Look at the camera"
        case .TurnHead: "Turn head slowly towards arrow"
        case .Smile: "Smile"
        case .Ok: "Ok"
        case .Blurry: "Blurry"
        case .Dark: "Dark"
        case .HoldStill: "Hold Still"
        case .Reseting: "Reseting"
        case .DontSmile: "Don't smile"
        }
    }
}

extension SelfieVerifierState {
    public var description: String {
        return switch self {
        case .Ok: "Ok"
        case .NoFaceFound: "No face found"
        case .Blurry: "Blurry"
        case .Dark: "Dark"
        case .ConfirmingFace: "Confirming face"
        case .BadFaceAngle: "Bad face angle"
        }
    }
}
