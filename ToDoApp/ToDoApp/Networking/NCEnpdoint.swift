//
//  NCEnpdoint.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation
import FileCache

public typealias Parameters = [String: Any]

public enum HTTPMethodType: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum APIError: String, Error {
    case invalidRequest = "400"
    case invalidAuth = "401"
    case elementNotFound = "404"
    case serverError = "500"
    case emptyData = "204"
    case invalidResponse = "123"
}

public class NCEndpoint<Response> {
    let path: String
    let method: HTTPMethodType
    let decode: (Data) throws -> Response?

    public init(path: String,
                method: HTTPMethodType = .get,
                decode: @escaping (Data) throws -> Response?)
    {
        self.method = method
        self.path = path
        self.decode = decode
    }
}

public extension NCEndpoint {
    static internal func make<T: Deserialization>(_ path: String, _ method: HTTPMethodType = .get) -> NCEndpoint<T> {
        NCEndpoint<T>.init(path: path,
                           method: method,
                           decode: { (jsonData: Data) -> T? in
            do {
                return try T.deserialize(from: jsonData)
            } catch {
                print(error)
                return nil
            }
        })
    }
}


