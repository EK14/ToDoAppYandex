//
//  DefaultNetworkingService.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation
import FileCache

class DefaultNetworkingService: NetworkingService {
    
    static public var shared = DefaultNetworkingService()
    
    // MARK: - Properties
    
    public var revision = 0
    
    // MARK: - Initializer
    
    private init() {}
    
    func getItemsList() async -> [ToDoItem] {
        do {
            let result: GetItemListResponse? = try await DefaultNetworkingService.request(Endpoints.getItemList)
        
            guard let result = result else {
                print("empty data")
                return []
            }

            return result.list
        } catch {
            print(error)
        }
        return []
    }
    
    // MARK: Request
    class func request<R: Deserialization>(
        _ endpoint: NCEndpoint<R>) async throws -> R? {
            guard let url = URL(string: ToDoApp.baseURL + endpoint.path) else {
            throw APIError.invalidRequest
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer Dior", forHTTPHeaderField: "Authorization")

        if endpoint.method == .post || endpoint.method == .put {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
//                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                throw error
            }
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            let result = try endpoint.decode(data)
            return result
        } catch {
            throw APIError.invalidRequest
        }
    }
    
    class func request<R: Deserialization, T: Serialization>(
        _ endpoint: NCEndpoint<R>,
        _ parameters: T) async throws -> R? {
            guard let url = URL(string: ToDoApp.baseURL + endpoint.path) else {
            throw APIError.invalidRequest
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer Dior", forHTTPHeaderField: "Authorization")

        if endpoint.method == .post || endpoint.method == .put {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
//                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                throw error
            }
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            let result = try endpoint.decode(data)
            return result
        } catch {
            throw APIError.invalidRequest
        }
    }

}
