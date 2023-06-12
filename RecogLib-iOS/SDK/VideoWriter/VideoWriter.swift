import AVFoundation

enum VideoWriterError: Error {
    case cannotWriteError
}

final class VideoWriter: NSObject {
    public weak var delegate: VideoWriterDelegate?
    private(set) var isRecording = false

    private let filePrefix = "VideoSample-"

    private var videoWriter: AVAssetWriter!
    private var videoWriterInput: AVAssetWriterInput!
    private var audioWriterInput: AVAssetWriterInput!
    private var sessionAtSourceTime: CMTime?
}

// MARK: - Public

extension VideoWriter {
    func start(isPortrait: Bool, requestedWidth: Int, requestedFPS: Int) {
        guard !isRecording else { return }
        isRecording = true
        sessionAtSourceTime = nil

        let outputAspectRatio: Double = 0.5625
        let videoWidth = Double(requestedWidth)
        let videoHeight = videoWidth * outputAspectRatio

        // FPS not yet used

        setupWriter(isPortrait: isPortrait, outputVideoWidth: videoWidth, outputVideoHeight: videoHeight)
    }

    func stop() {
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

    func stopAndCancel() {
        guard isRecording else { return }
        isRecording = false
        videoWriter.cancelWriting()
        sessionAtSourceTime = nil
    }

    func pause() {
        isRecording = false
    }

    func resume() {
        isRecording = true
    }

    func captureOutput(sampleBuffer: CMSampleBuffer) {
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
    private func setupWriter(isPortrait: Bool, outputVideoWidth: Double, outputVideoHeight: Double) {
        do {
            let outputFileName = "\(filePrefix)\(ProcessInfo.processInfo.globallyUniqueString).mp4"
            clearTemporaryFiles()
            let url = getDocumentsDirectory()
                .appendingPathComponent(outputFileName)

            videoWriter = try AVAssetWriter(url: url, fileType: AVFileType.mp4)
            videoWriterInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: [
                AVVideoCodecKey: AVVideoCodecType.h264,
                AVVideoWidthKey: isPortrait ? outputVideoHeight : outputVideoWidth,
                AVVideoHeightKey: isPortrait ? outputVideoWidth : outputVideoHeight,
                AVVideoCompressionPropertiesKey: [AVVideoAverageBitRateKey: 1000000]
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
        } catch {
            ApplicationLogger.shared.Error(error.localizedDescription)
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func canWrite() -> Bool {
        return isRecording
            && videoWriter != nil
            && videoWriter.status == .writing
    }

    private func clearTemporaryFiles() {
        let docURL = getDocumentsDirectory()
        let docDirectory = try? FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: nil)
        docDirectory?
            .filter { $0.lastPathComponent.range(of: "^\(filePrefix)", options: [.regularExpression, .caseInsensitive, .diacriticInsensitive]) != nil }
            .forEach { file in
                try? FileManager.default.removeItem(at: file)
            }
    }
}
