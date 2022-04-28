import AVFoundation

public protocol VideoWriterDelegate: AnyObject {
    func didTakeVideo(_ videoAsset: AVURLAsset)
}
