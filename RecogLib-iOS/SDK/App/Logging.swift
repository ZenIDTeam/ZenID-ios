//
//  Log.swift
//  RecogLib-iOS
//
//  Created by Jiri Sacha on 29.03.2021.
//  Copyright © 2021 Marek Stana. All rights reserved.
//

public protocol LoggerProtocol {
    func Error(_ message: String);
    func Warn(_ message: String);
    func Info(_ message: String);
    func Debug(_ message: String);
    func Verbose(_ message: String);
}

final public class ApplicationLogger {
    
    public static let shared = ApplicationLogger()
    
    private var logger: LoggerProtocol?

    private init() {}
    
    public func startLogging(logger: LoggerProtocol) {
        self.logger = logger
    }
    
    public func Error(_ message: String) {
        self.logger?.Error(message)
    }
    
    public func Warn(_ message: String) {
        self.logger?.Warn(message)
    }
    
    public func Info(_ message: String) {
        self.logger?.Info(message)
    }
    
    public func Debug(_ message: String) {
        self.logger?.Debug(message)
    }
    
    public func Verbose(_ message: String) {
        self.logger?.Verbose(message)
    }
    
    public func disableRecognitionLogging() {
        clearZenidListeners()
    }
    
    public func enableRecognitionLogging() {
        addZenidListener()
    }
}
