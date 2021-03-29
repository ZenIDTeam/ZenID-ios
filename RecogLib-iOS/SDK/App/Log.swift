//
//  Log.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 29.03.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

import CocoaLumberjackSwift

final public class Log {
    
    public static let shared = Log()

    private init() {}
    
    public func startLogging(logLevel: DDLogLevel = DDLogLevel.all) {
        dynamicLogLevel = logLevel
        
        // Use os_log
        DDLog.add(DDOSLogger.sharedInstance)

        // use file logger
        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 365
        DDLog.add(fileLogger)
    }
    
    public func setLogLevel(logLevel: DDLogLevel) {
        dynamicLogLevel = logLevel
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
