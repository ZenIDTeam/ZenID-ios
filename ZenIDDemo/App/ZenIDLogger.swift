//
//  Logger.swift
//  ZenIDDemo
//
//  Created by Jiri Sacha on 03.05.2021.
//  Copyright © 2021 Trask, a.s. All rights reserved.
//

import Foundation
import RecogLib_iOS
import OSLog

final class ZenIDLogger : LoggerProtocol {
    
    public static let shared = ZenIDLogger()
    
    init() {
        /*// The log level that can dynamically limit log messages
        dynamicLogLevel = logLevel
        
        // Use os_log
        DDLog.add(DDOSLogger.sharedInstance)

        // use file logger
        self.fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 365
        DDLog.add(fileLogger) */
    }
    
    func startLogging() {
        ApplicationLogger.shared.startLogging(logger: self)
    }
    
    func getLogArchivePath() -> String? {
        /*let logFilePaths = fileLogger.logFileManager.sortedLogFilePaths
        guard !logFilePaths.isEmpty else { return nil }
        
        guard let zipPath = URL(string: fileLogger.logFileManager.logsDirectory)?.appendingPathComponent("zenIDlog.zip") else { return nil }
        
        try? FileManager.default.removeItem(at: zipPath)
        
        let zipArch = SSZipArchive(path: zipPath.absoluteString)
        zipArch.open()
        for logFilePath in logFilePaths {
            zipArch.writeFile(logFilePath, withPassword: nil)
        }
        zipArch.close() */
        
        return nil //zipPath.absoluteString
    }
    
    public func Error(_ message: String) {
        os_log(.error, "%@", message)
    }
    
    public func Warn(_ message: String) {
        os_log(.fault, "%@", message)
    }
    
    public func Info(_ message: String) {
        os_log(.info, "%@", message)
    }
    
    public func Debug(_ message: String) {
        os_log(.debug, "%@", message)
    }
    
    public func Verbose(_ message: String) {
        os_log(.default, "%@", message)
    }
}
