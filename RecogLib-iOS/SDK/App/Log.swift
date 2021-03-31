//
//  Log.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 29.03.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import CocoaLumberjackSwift
import ZipArchive

final public class Log {
    
    public static let shared = Log()
    
    private var fileLogger: DDFileLogger!

    private init() {}
    
    public func startLogging(logLevel: DDLogLevel = DDLogLevel.all) {
        dynamicLogLevel = logLevel
        
        // Use os_log
        DDLog.add(DDOSLogger.sharedInstance)

        // use file logger
        self.fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 365
        DDLog.add(fileLogger)
    }
    
    public func setLogLevel(logLevel: DDLogLevel) {
        dynamicLogLevel = logLevel
    }
    
    public func getLogArchivePath() -> String? {
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
