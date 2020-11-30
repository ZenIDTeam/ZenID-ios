//
//  Data+resizing.swift
//  ZenIDDemo
//
//  Created by Marek Stana on 19/06/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import UIKit

extension Data {

    public func resizeImage(maxResolution: Int, compression: CGFloat, addMetadata metadata: [CFString: Any]? = nil, size: CGSize? = nil) -> Data? {
        guard let imageSource = CGImageSourceCreateWithData(self as CFData, nil),
            var metadata = metadata ?? CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [CFString: Any],
            let srcMaxResolution = getSrcMaxResolution(metadata: metadata, size: size) else {
                return nil
        }

        let newImageData = NSMutableData()
        metadata[kCGImageDestinationLossyCompressionQuality] = compression

        let scaleOptions: [CFString: Any] = [kCGImageSourceThumbnailMaxPixelSize: Swift.min(srcMaxResolution, maxResolution),
                                             kCGImageSourceCreateThumbnailFromImageAlways: true]

        guard let uniformTypeIdentifier = CGImageSourceGetType(imageSource),
            let cgImageDestination = CGImageDestinationCreateWithData(newImageData, uniformTypeIdentifier, 1, nil),
            let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, scaleOptions as CFDictionary) else {
                return nil
        }

        CGImageDestinationAddImage(cgImageDestination, scaledImage, metadata as CFDictionary)
        CGImageDestinationFinalize(cgImageDestination)
        return newImageData as Data
    }

    private func getSrcMaxResolution(metadata: [CFString: Any], size: CGSize?) -> Int? {
        var width = metadata[kCGImagePropertyPixelWidth] as? Int
        var height = metadata[kCGImagePropertyPixelHeight] as? Int
        if let size = size {
            width = Int(size.width)
            height = Int(size.height)
        }
        guard let finalWidth = width, let finalHeight = height else { return nil }
        return Swift.max(finalWidth, finalHeight)
    }
}
