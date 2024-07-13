//
//  URLSession+Extensions.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 12.07.2024.
//

import Foundation

extension URLSession {
    func dataTask(for urlRequest: URLRequest) throws -> (Data, URLResponse) {
        let group = DispatchGroup()
        var result: (Data?, URLResponse?, Error?)

        let task = self.dataTask(with: urlRequest) { data, response, error in
            result = (data, response, error)
            group.leave()
        }
        
        defer {
            task.cancel()
        }

        group.enter()
        task.resume()
        group.wait()

        if let error = result.2 {
            throw error
        }

        guard let data = result.0, let response = result.1 else {
            throw URLError(.badServerResponse)
        }

        return (data, response)
    }
}

