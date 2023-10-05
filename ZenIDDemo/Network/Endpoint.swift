//
//  Endpoint.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 15.01.19.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//
import Foundation
import RecogLib_iOS

typealias Headers = [String: String]
typealias Parameters = [String: Any]
typealias Path = String

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

class Endpoint<T> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    let decode: (Data) throws -> T

    init(method: Method = .get,
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
    convenience init(method: Method = .get,
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

class UploadEndpoint<T>: Endpoint<T> {
    let data: Data
    init(path: Path,
         data: Data,
         parameters: Parameters? = nil,
         decode: @escaping (Data) throws -> T) {
        self.data = data
        super.init(method: .post, path: path, parameters: parameters, decode: decode)
    }
}

struct MultiDataPart {
    enum DataType: String {
        case photo = "image/jpeg"
        case video = "video/mp4"
        case signature = "text/plain"

        var name: String {
            switch self {
            case .photo: return "picture"
            case .video: return "video"
            case .signature: return "signature"
            }
        }
    }

    let type: DataType
    let data: Data
}

class MultipartUploadEndpoint<T>: Endpoint<T> {
    let dataParts: [MultiDataPart]
    init(path: Path,
         dataParts: [MultiDataPart],
         parameters: Parameters? = nil,
         decode: @escaping (Data) throws -> T) {
        self.dataParts = dataParts
        super.init(method: .post, path: path, parameters: parameters, decode: decode)
    }
}

extension UploadEndpoint where T: Swift.Decodable {
    convenience init(path: Path,
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

extension MultipartUploadEndpoint where T: Swift.Decodable {
    convenience init(path: Path,
                     dataParts: [MultiDataPart],
                     parameters: Parameters? = nil) {
        self.init(path: path,
                  dataParts: dataParts,
                  parameters: parameters) {
            ApplicationLogger.shared.Verbose("Response body: \(String(data: $0, encoding: String.Encoding.utf8) ?? "")")
            return try JSONDecoder().decode(T.self, from: $0)
        }
    }
}
