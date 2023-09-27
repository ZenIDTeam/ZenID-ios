
import UIKit
import AVFoundation
import RecogLib_iOS


protocol CameraViewControllerDelegate: AnyObject {
    func didTakePhoto(_ imageData: Data?, type: PhotoType, result: UnifiedResult?)
    func didTakeVideo(_ videoURL: URL?, type: PhotoType)
    func didFinishPDF()
    func didCancel()
}
