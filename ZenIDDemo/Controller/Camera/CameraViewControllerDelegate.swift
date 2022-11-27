import AVFoundation
import Common
import RecogLib_iOS
import UIKit

protocol CameraViewControllerDelegate: AnyObject {
    func didTakePhoto(_ imageData: Data?, type: PhotoType, result: UnifiedResult?)
    func didTakeVideo(_ videoURL: URL?, type: PhotoType)
    func didFinishPDF()
}
