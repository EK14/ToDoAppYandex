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
    
    public init(status: String = "ok", list: [ToDoItem], revision: Int32? = nil) {
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

extension GetItemListResponse: Serialization {
    static func serialize(_ data: GetItemListResponse) -> Data? {
        var jsonDict = [String: Any]()
        
        jsonDict["status"] = data.status
        
        jsonDict["element"] = data.list[0].json
        
        jsonDict["revision"] = nil
        
        print(jsonDict)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: [])
            return jsonData
        } catch {
            print("Error encoding model: \(error)")
        }
        return nil
    }
}
