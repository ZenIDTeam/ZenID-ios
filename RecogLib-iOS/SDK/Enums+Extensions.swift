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
        switch self {
        case .Idc:
            return "Idc"
        case .Drv:
            return "Drv"
        case .Pas:
            return "Pas"
        case .Res:
            return "Res"
        case .Gun:
            return "Gun"
        case .Hic:
            return "Hic"
        case .Std:
            return "Std"
        case .Car:
            return "Car"
        case .Birth:
            return "Birth"
        case .Add:
            return "Add"
        case .Ide:
            return "Ide"
        case .Vis:
            return "Vis"
        }
    }
}

extension SupportedLanguages {
    public var description: String {
        switch self {
        case .Czech:
            return "Cs"
        case .English:
            return "En"
        case .Polish:
            return "Pl"
        case .German:
            return "De"
        }
    }
}

extension DocumentVerifierState {
    public var description: String {
        switch self {
        case .NoMatchFound:
            return "No match found"
        case .AlignCard:
            return "Align card"
        case .HoldSteady:
            return "Hold steady"
        case .Blurry:
            return "Blurry"
        case .ReflectionPresent:
            return "Reflection present"
        case .Ok:
            return "Ok"
        case .Hologram:
            return "Hologram error"
        case .Dark:
            return "Too dark"
        case .Barcode:
            return "Barcode not readable"
        }
    }
}

extension HologramState {
    public var description: String {
        switch self {
        case .Center:
            return "Center"
        case .TiltLeftAndRight:
            return "Tilt left and right"
        case .TiltUpAndDown:
            return "Tilt up and down"
        case .Ok:
            return "Ok"
        }
    }
}

extension FaceLivenessVerifierState {
    public var description: String {
        switch self {
        case .LookAtMe:
            return "Look at the camera"
        case .TurnHead:
            return "Turn head slowly towards arrow"
        case .Smile:
            return "Smile"
        case .Ok:
            return "Ok"
        case .Blurry:
            return "Blurry"
        case .Dark:
            return "Dark"
        case .HoldStill:
            return "Hold Still"
        }
    }
}

extension SelfieVerifierState {
    public var description: String {
        switch self {
        case .Ok:
            return "Ok"
        case .NoFaceFound:
            return "No face found"
        case .Blurry:
            return "Blurry"
        case .Dark:
            return "Dark"
        case .ConfirmingFace:
            return "Confirming face"
        case .BadFaceAngle:
            return "Bad face angle"
        }
    }
}
