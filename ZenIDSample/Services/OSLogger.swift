//
//  OSLogger.swift
//  ZenID Sample
//
//  Logger bridge for ZenID SDK and application.
//

import Foundation
import OSLog
import ZenID

/// Logger bridge for ZenID SDK and application.
struct OSLogger: ZenidLogger {

    private let prefix: String

    init(prefix: String = "ZenID SDK") {
        self.prefix = prefix
    }

    /// App-level logger for sample app
    static let app = OSLogger(prefix: "Sample App")

    func error(_ message: String) {
        os_log(.error, "%@: %@", prefix, message)
    }

    func warn(_ message: String) {
        os_log(.fault, "%@: %@", prefix, message)
    }

    func info(_ message: String) {
        os_log(.info, "%@: %@", prefix, message)
    }

    func debug(_ message: String) {
        os_log(.debug, "%@: %@", prefix, message)
    }

    func verbose(_ message: String) {
        os_log(.default, "%@: %@", prefix, message)
    }
}
