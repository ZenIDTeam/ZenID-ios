//
//  Logger.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 03.05.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS
import CocoaLumberjackSwift
import ZipArchive

final class ZenIDLogger : LoggerProtocol {
    
    public static let shared = ZenIDLogger(logLevel: DDLogLevel.all)
    
    private var fileLogger: DDFileLogger!
    
    init(logLevel: DDLogLevel = DDLogLevel.all) {
        // The log level that can dynamically limit log messages
        dynamicLogLevel = logLevel
        
        // Use os_log
        DDLog.add(DDOSLogger.sharedInstance)

        // use file logger
        self.fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 365
        DDLog.add(fileLogger)
    }
    
    func startLogging() {
        //ApplicationLogger.shared.startLogging(logger: self)
    }
    
    func getLogArchivePath() -> String? {
        let logFilePaths = fileLogger.logFileManager.sortedLogFilePaths
        guard !logFilePaths.isEmpty else { return nil }
        
        guard let zipPath = URL(string: fileLogger.logFileManager.logsDirectory)?.appendingPathComponent("zenIDlog.zip") else { return nil }
        
        try? FileManager.default.removeItem(at: zipPath)
        
        let zipArch = SSZipArchive(path: zipPath.absoluteString)
        zipArch.open()
        for logFilePath in logFilePaths {
            zipArch.writeFile(logFilePath, withPassword: nil)
        }
        zipArch.close()
        
        return zipPath.absoluteString
    }
    
    public func Error(_ message: String) {
        DDLogError(message);
    }
    
    public func Warn(_ message: String) {
        DDLogWarn(message);
    }
    
    public func Info(_ message: String) {
        DDLogInfo(message);
    }
    
    public func Debug(_ message: String) {
        DDLogDebug(message);
    }
    
    public func Verbose(_ message: String) {
        DDLogVerbose(message);
    }
}
