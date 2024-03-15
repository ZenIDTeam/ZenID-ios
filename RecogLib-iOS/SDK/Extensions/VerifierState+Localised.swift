import Foundation


extension DocumentVerifierState {
    
    public var localizedDescription: String {
        return switch self {
        case .NoMatchFound: LocalizedString("documentVerifierState-NoMatchFound")
        case .AlignCard: LocalizedString("documentVerifierState-AlignCard")
        case .HoldSteady: LocalizedString("documentVerifierState-HoldSteady")
        case .Blurry: LocalizedString("documentVerifierState-Blurry")
        case .ReflectionPresent: LocalizedString("documentVerifierState-ReflectionPresent")
        case .Ok: LocalizedString("documentVerifierState-Ok")
        case .Hologram: LocalizedString("documentVerifierState-Hologram")
        case .Dark: LocalizedString("documentVerifierState-Dark")
        case .Barcode: LocalizedString("documentVerifierState-Barcode")
        case .TextNotReadable: LocalizedString("documentVerifierState-TextNotReadable")
        case .Nfc: LocalizedString("documentVerifierState-Nfc")
        }
    }
}

extension HologramState {
    
    public var localizedDescription: String {
        return switch self {
        case .Center: LocalizedString("hologramState-Center")
        case .TiltLeftAndRight: LocalizedString("hologramState-TiltLeftAndRight")
        case .TiltUpAndDown: LocalizedString("hologramState-TiltUpAndDown")
        case .Ok: LocalizedString("hologramState-Ok")
        case .TimedOut: LocalizedString("hologramState-TimedOut")
        case .TiltLeft: LocalizedString("hologramState-TiltLeft")
        case .TiltRight: LocalizedString("hologramState-TiltRight")
        case .TiltUp: LocalizedString("hologramState-TiltUp")
        case .TiltDown: LocalizedString("hologramState-TiltDown")
        }
    }
}

extension FaceLivenessVerifierState {
    
    public var localizedDescription: String {
        return switch self {
        case .LookAtMe: LocalizedString("faceLivenessVerifierState-LookAtMe")
        case .TurnHead: LocalizedString("faceLivenessVerifierState-TurnHead")
        case .Smile: LocalizedString("faceLivenessVerifierState-Smile")
        case .Ok: LocalizedString("faceLivenessVerifierState-Ok")
        case .Blurry: LocalizedString("faceLivenessVerifierState-Blurry")
        case .Dark: LocalizedString("faceLivenessVerifierState-Dark")
        case .HoldStill: LocalizedString("faceLivenessVerifierState-HoldStill")
        case .Reseting: LocalizedString("faceLivenessVerifierState-Reseting")
        case .DontSmile: LocalizedString("faceLivenessVerifierState-DontSmile")
        }
    }
}

extension SelfieVerifierState {
    
    public var localizedDescription: String {
        return switch self {
        case .Ok: LocalizedString("selfieVerifierState-Ok")
        case .NoFaceFound: LocalizedString("selfieVerifierState-NoFaceFound")
        case .Blurry: LocalizedString("selfieVerifierState-Blurry")
        case .Dark: LocalizedString("selfieVerifierState-Dark")
        case .ConfirmingFace: LocalizedString("selfieVerifierState-ConfirmingFace")
        case .BadFaceAngle: LocalizedString("selfieVerifierState-BadFaceAngle")
        }
    }
}
