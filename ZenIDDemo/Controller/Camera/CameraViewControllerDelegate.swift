
import UIKit
import AVFoundation
import RecogLib_iOS


protocol CameraViewControllerDelegate: class {
    func didTakePhoto(_ imageData: Data?, type: PhotoType, result: UnifiedResult?)
    func didTakeVideo(_ videoAsset: AVURLAsset?, type: PhotoType)
    func didFinishPDF()
}
