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
    
    public var localizedDescription: String {
        return switch self {
        case .Idc: "document-role-Idc".localised
        case .Drv: "document-role-Drv".localised
        case .Pas: "document-role-Pas".localised
        case .Res: "document-role-Res".localised
        case .Gun: "document-role-Gun".localised
        case .Hic: "document-role-Hic".localised
        case .Std: "document-role-Std".localised
        case .Car: "document-role-Car".localised
        case .Birth: "document-role-Birth".localised
        case .Add: "document-role-Add".localised
        case .Ide: "document-role-Ide".localised
        case .Vis: "document-role-Vis".localised
        case .Exp: "document-role-Exp".localised
        }
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
    
    var localizedDescription: String { description }
        
    public var description: String {
        return switch self {
        case .NoMatchFound: "document-state-NoMatchFound".localised
        case .AlignCard: "document-state-AlignCard".localised
        case .HoldSteady: "document-state-HoldSteady".localised
        case .Blurry: "document-state-Blurry".localised
        case .ReflectionPresent: "document-state-ReflectionPresent".localised
        case .Ok: "document-state-Ok".localised
        case .Hologram: "document-state-HologramError".localised
        case .Dark: "document-state-Dark".localised
        case .Barcode: "document-state-Barcode".localised
        case .TextNotReadable: "document-state-TextNotReadable".localised
        case .Nfc: "document-state-Nfc".localised
        }
    }
}

extension HologramState {
    
    public var description: String {
        return switch self {
        case .Center: "hologram-Center".localised
        case .TiltLeftAndRight: "hologram-TiltLeftAndRight".localised
        case .TiltUpAndDown: "hologram-TiltUpAndDown".localised
        case .Ok: "hologram-Ok".localised
        case .TimedOut: "hologram-TimedOut".localised
        case .TiltLeft: "hologram-TiltLeft".localised
        case .TiltRight: "hologram-TiltRight".localised
        case .TiltUp: "hologram-TiltUp".localised
        case .TiltDown: "hologram-TiltDown".localised
        }
    }
}

extension FaceLivenessVerifierState {
    
    public var description: String {
        return switch self {
        case .LookAtMe: "faceliveness-state-LookAtMe".localised
        case .TurnHead: "faceliveness-state-TurnHead".localised
        case .Smile: "faceliveness-state-Smile".localised
        case .Ok: "faceliveness-state-Ok".localised
        case .Blurry: "faceliveness-state-Blurry".localised
        case .Dark: "faceliveness-state-Dark".localised
        case .HoldStill: "faceliveness-state-HoldStill".localised
        case .Reseting: "faceliveness-state-Reseting".localised
        case .DontSmile: "faceliveness-state-DontSmile".localised
        }
    }
}

extension SelfieVerifierState {
    
    public var description: String {
        return switch self {
        case .Ok: "selfie-state-Ok".localised
        case .NoFaceFound: "selfie-state-NoFaceFound".localised
        case .Blurry: "selfie-state-Blurry".localised
        case .Dark: "selfie-state-Dark".localised
        case .ConfirmingFace: "selfie-state-ConfirmingFace".localised
        case .BadFaceAngle: "selfie-state-BadFaceAngle".localised
        }
    }
}
