//
//  GetItemListResponse.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation
import FileCache

protocol NetworkingModels {}

struct GetItemListResponse: NetworkingModels {
    let status: String
    let list: [ToDoItem]
    let revision: Int32?
    
    public init(status: String, list: [ToDoItem], revision: Int32) {
        self.status = status
        self.list = list
        self.revision = revision
    }
}

extension GetItemListResponse: Deserialization {
    static func deserialize(from data: Data) -> GetItemListResponse? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let status = json["status"] as? String,
               let list = json["list"] as? [[String: Any]],
               let revision = json["revision"] as? Int32 {

                var todoItems = [ToDoItem]()
                for item in list {
                    if let todoItem = ToDoItem.parse(json: item) {
                        todoItems.append(todoItem)
                    }
                }

                let response = GetItemListResponse(status: status, list: todoItems, revision: revision)
                return response
            }
        } catch {
            print(error)
        }
        return nil
    }
}

