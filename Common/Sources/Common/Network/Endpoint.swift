//
//  Endpoint.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 15.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//
import Foundation
import RecogLib_iOS

public typealias Headers = [String: String]
public typealias Parameters = [String: Any]
public typealias Path = String

public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public class Endpoint<T> {
    public let method: Method
    public let path: Path
    public let parameters: Parameters?
    public let decode: (Data) throws -> T

    public init(method: Method = .get,
                path: Path,
                parameters: Parameters? = nil,
                decode: @escaping (Data) throws -> T) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.decode = decode
    }
}

extension Endpoint where T: Swift.Decodable {
    public convenience init(method: Method = .get,
                            path: Path,
                            parameters: Parameters? = nil) {
        self.init(method: method,
                  path: path,
                  parameters: parameters) {
            ApplicationLogger.shared.Verbose("Response body: \(String(data: $0, encoding: String.Encoding.utf8) ?? "")")
            return try JSONDecoder().decode(T.self, from: $0)
        }
    }
}

public class UploadEndpoint<T>: Endpoint<T> {
    public let data: Data
    public init(path: Path,
                data: Data,
                parameters: Parameters? = nil,
                decode: @escaping (Data) throws -> T) {
        self.data = data
        super.init(method: .post, path: path, parameters: parameters, decode: decode)
    }
}

extension UploadEndpoint where T: Swift.Decodable {
    public convenience init(path: Path,
                            data: Data,
                            parameters: Parameters? = nil) {
        self.init(path: path,
                  data: data,
                  parameters: parameters) {
            ApplicationLogger.shared.Verbose("Response body: \(String(data: $0, encoding: String.Encoding.utf8) ?? "")")
            return try JSONDecoder().decode(T.self, from: $0)
        }
    }
}
