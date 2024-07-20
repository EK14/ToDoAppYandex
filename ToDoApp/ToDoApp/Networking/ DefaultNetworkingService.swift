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
    
    public var revision: Int32?
    
    // MARK: - Initializer
    
    private init() {}
    
    func getItemsList() async -> [ToDoItem] {
        do {
            let result: GetItemListResponse? = try await request(Endpoints.getItemList)
        
            guard let result = result else {
                print("empty data")
                return []
            }
            self.revision = result.revision
            return result.list
        } catch {
            print(error)
        }
        return []
    }
    
    func addToDoItem(_ item: ToDoItem) async {
        do {
            let result: ToDoItem? = try await request(Endpoints.addItem, GetItemListResponse(list: [item]))
        } catch {
            print(error)
        }
    }
    
    // MARK: - Request
    
    private func request<R: Deserialization>(
        _ endpoint: NCEndpoint<R>) async throws -> R? {
            guard let url = URL(string: ToDoApp.baseURL + endpoint.path) else {
            throw APIError.invalidRequest
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer Dior", forHTTPHeaderField: "Authorization")

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
    
    private func request<R: Deserialization, T: Serialization>(
        _ endpoint: NCEndpoint<R>,
        _ parameters: T) async throws -> R? {
            guard let url = URL(string: ToDoApp.baseURL + endpoint.path) else {
            throw APIError.invalidRequest
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer Dior", forHTTPHeaderField: "Authorization")
        request.setValue("\(revision!)", forHTTPHeaderField: "X-Last-Known-Revision")

        if endpoint.method == .post || endpoint.method == .put {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("50", forHTTPHeaderField: "X-Generate-Fails")
            request.httpBody =  T.serialize(parameters)
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
