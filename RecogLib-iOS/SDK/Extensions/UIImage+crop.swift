import AVFoundation
import UIKit
import VideoToolbox

public enum ImageFlip: Int {
    case none
    case fromLandScape
    case fromPortrait
}

extension UIImage {
    
    public convenience init?(pixelBuffer: CVPixelBuffer, crop: CGRect? = nil) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        if let cropRect = crop {
            cgImage = cgImage?.cropping(to: cropRect)
        }

        if let cgImage = cgImage {
            self.init(cgImage: cgImage)
        } else {
            return nil
        }
    }

    func toCVPixelBuffer() -> CVPixelBuffer? {
        guard let image = cgImage else {
            return nil
        }
        let frameSize = CGSize(width: image.width, height: image.height)

        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA, nil, &pixelBuffer)

        if status != kCVReturnSuccess {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)

        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))

        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }

    func toCMSampleBuffer() -> CMSampleBuffer? {
        let pixelBuffer = toCVPixelBuffer()
        var newSampleBuffer: CMSampleBuffer?
        var timimgInfo: CMSampleTimingInfo = .init(duration: CMTime(seconds: 1, preferredTimescale: 1), presentationTimeStamp: CMTime(seconds: 1, preferredTimescale: 1), decodeTimeStamp: CMTime(seconds: 1, preferredTimescale: 1))
        var videoInfo: CMVideoFormatDescription?
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: nil, imageBuffer: pixelBuffer!, formatDescriptionOut: &videoInfo)
        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault,
                                           imageBuffer: pixelBuffer!,
                                           dataReady: true,
                                           makeDataReadyCallback: nil,
                                           refcon: nil,
                                           formatDescription: videoInfo!,
                                           sampleTiming: &timimgInfo,
                                           sampleBufferOut: &newSampleBuffer)
        return newSampleBuffer!
    }

    func cropCameraImage(previewLayer: AVCaptureVideoPreviewLayer) -> UIImage? {
        var image = UIImage()

        let previewImageLayerBounds = previewLayer.bounds

        let originalWidth = size.width
        let originalHeight = size.height

        let A = previewImageLayerBounds.origin
        let B = CGPoint(x: previewImageLayerBounds.size.width, y: previewImageLayerBounds.origin.y)
        let D = CGPoint(x: previewImageLayerBounds.size.width, y: previewImageLayerBounds.size.height)

        let a = previewLayer.captureDevicePointConverted(fromLayerPoint: A)
        let b = previewLayer.captureDevicePointConverted(fromLayerPoint: B)
        let d = previewLayer.captureDevicePointConverted(fromLayerPoint: D)

        let posX = floor(b.x * originalHeight)
        let posY = floor(b.y * originalWidth)

        let width: CGFloat = d.x * originalHeight - b.x * originalHeight
        let height: CGFloat = a.y * originalWidth - b.y * originalWidth

        let cropRect = CGRect(x: posX, y: posY, width: width, height: height)

        if let imageRef = cgImage?.cropping(to: cropRect) {
            image = UIImage(cgImage: imageRef, scale: 1.0, orientation: .up)
        }

        return image
    }

    func cropCameraImageLandscape(previewLayer: AVCaptureVideoPreviewLayer) -> UIImage? {
        let originalSize = CGSize(width: size.height, height: size.width)
        let visibleLayerFrame = previewLayer.bounds

        let metaRect: CGRect = (previewLayer.metadataOutputRectConverted(fromLayerRect: visibleLayerFrame))

        let cropRect: CGRect = CGRect(
            x: metaRect.origin.y * originalSize.height,
            y: metaRect.origin.x * originalSize.width,
            width: metaRect.size.height * originalSize.height,
            height: metaRect.size.width * originalSize.width).integral

        return UIImage(cgImage: cgImage!.cropping(to: cropRect)!,
                       scale: 1,
                       orientation: imageOrientation)
    }

    func flip(_ flipMethod: ImageFlip) -> UIImage {
        guard let cgImage else {
            return self
        }

        switch flipMethod {
        case .fromPortrait:
            return UIImage(cgImage: cgImage, scale: scale, orientation: .leftMirrored)
        case .fromLandScape:
            return UIImage(cgImage: cgImage, scale: scale, orientation: .right)
        default:
            return self
        }
    }
    
    /// Crop image to fit size.
    /// - Parameter cropSize: Size that is represented as proportion.
    /// - Returns: Cropped image.
    func crop(useProportions cropSize: CGSize) -> UIImage? {
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let targetRect = CGRect(x: 0, y: 0, width: cropSize.width, height: cropSize.height)
        let cropRect = targetRect.rectThatFitsRect(imageRect)
        guard let croppedImage = cgImage?.cropping(to: cropRect) else { return nil }
        return UIImage(cgImage: croppedImage)
    }
        
    /// Mirror UIImage data.
    /// - Returns: Mirrored UIImage.
    func mirrored() -> UIImage? {
        // Step 1: Create a CGContext with the mirrored transformation
        guard let cgImage = self.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: bitmapInfo.rawValue
        ) else {
            return nil
        }
        
        // Step 2: Apply the mirror transformation
        context.translateBy(x: CGFloat(width), y: 0)
        context.scaleBy(x: -1.0, y: 1.0)
        
        // Step 3: Draw the UIImage into the CGContext
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        
        // Step 4: Extract the UIImage from the CGContext
        guard let mirroredCGImage = context.makeImage() else { return nil }
        return UIImage(cgImage: mirroredCGImage)
    }
}
