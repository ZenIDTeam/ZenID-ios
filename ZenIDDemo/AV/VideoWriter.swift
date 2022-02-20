//
//  VideoWriter.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 05/07/2020.
//  Copyright © 2020 Trask, a.s. All rights reserved.
//

import AVFoundation
import RecogLib_iOS

enum VideoWriterError : Error {
    case cannotWriteError
}

public class VideoWriter: NSObject {
    public weak var delegate: VideoWriterDelegate?
    public private(set) var isRecording = false
    
    private let filePrefix = "VideoSample-"

    private var videoWriter: AVAssetWriter!
    private var videoWriterInput: AVAssetWriterInput!
    private var audioWriterInput: AVAssetWriterInput!
    private var sessionAtSourceTime: CMTime?
}

// MARK: - Public
extension VideoWriter {
    public func start(isPortrait: Bool) {
        guard !isRecording else { return }
        isRecording = true
        sessionAtSourceTime = nil
        setupWriter(isPortrait: isPortrait)
    }
    
    public func stop() {
        guard isRecording else { return }
        isRecording = false
        videoWriter.finishWriting { [weak self] in
            self?.sessionAtSourceTime = nil
            guard let self = self else { return }
            if let delegate = self.delegate {
                let url = self.videoWriter.outputURL
                let videoAsset = AVURLAsset(url: url)
                DispatchQueue.main.async { [weak delegate] in
                    delegate?.didTakeVideo(videoAsset)
                }
            }
        }
    }
    
    public func pause() {
        isRecording = false
    }
    
    public func resume() {
        isRecording = true
    }
    
    public func captureOutput(sampleBuffer: CMSampleBuffer) {
        guard CMSampleBufferDataIsReady(sampleBuffer) else { return }
        
        let writable = canWrite()
        if writable, sessionAtSourceTime == nil {
            // Start writing
            sessionAtSourceTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            videoWriter.startSession(atSourceTime: sessionAtSourceTime!)
        }
        
        if videoWriterInput.isReadyForMoreMediaData {
            // Write video buffer
            videoWriterInput.append(sampleBuffer)
        }
    }
}

// MARK: - Private
extension VideoWriter {
    private func setupWriter(isPortrait: Bool) {
        do {
            let outputFileName = "\(filePrefix)\(ProcessInfo.processInfo.globallyUniqueString).mp4"
            clearTemporaryFiles()
            let url = getDocumentsDirectory()
                .appendingPathComponent(outputFileName)
            
            videoWriter = try AVAssetWriter(url: url, fileType: AVFileType.mp4)
            videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: [
                AVVideoCodecKey: AVVideoCodecType.h264,
                AVVideoWidthKey: isPortrait ? 360.0 : 640.0,
                AVVideoHeightKey: isPortrait ? 640.0 : 360,
                AVVideoCompressionPropertiesKey: [AVVideoAverageBitRateKey: 1_000_000]
              ])
            videoWriterInput.expectsMediaDataInRealTime = true
            
            if videoWriter.canAdd(videoWriterInput) {
                videoWriter.add(videoWriterInput)
            }
            
            videoWriter.startWriting()
            // Means can not write to file
            if videoWriter.status != .writing {
                throw VideoWriterError.cannotWriteError
            }
        }
        catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func canWrite() -> Bool {
        return isRecording
            && videoWriter != nil
            && videoWriter.status == .writing
    }
    
    private func clearTemporaryFiles() {
        let docURL = getDocumentsDirectory()
        let docDirectory = try? FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: nil)
        docDirectory?
            .filter{ $0.lastPathComponent.range(of: "^\(filePrefix)", options: [.regularExpression, .caseInsensitive, .diacriticInsensitive]) != nil }
            .forEach { file in
            try? FileManager.default.removeItem(at: file)
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
/*extension VideoWriter: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard CMSampleBufferDataIsReady(sampleBuffer) else { return }
        
        let writable = canWrite()
        if writable, sessionAtSourceTime == nil {
            // Start writing
            sessionAtSourceTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            videoWriter.startSession(atSourceTime: sessionAtSourceTime!)
        }
        
        if output == cameraVideoOutput {
            if videoWriterInput.isReadyForMoreMediaData {
                // Write video buffer
                videoWriterInput.append(sampleBuffer)
            }
        }
    }
}*/
