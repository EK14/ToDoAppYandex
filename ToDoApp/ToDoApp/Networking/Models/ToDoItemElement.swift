//
//  ToDoItemElement.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 20.07.2024.
//

import Foundation
import FileCache

struct ToDoItemElement: NetworkingModels {
    let status: String
    let element: ToDoItem
    let revision: Int32?
    
    public init(status: String = "ok", element: ToDoItem, revision: Int32? = nil) {
        self.status = status
        self.element = element
        self.revision = revision
    }
}

extension ToDoItemElement: Serialization {
    static func serialize(_ data: ToDoItemElement) -> Data? {
        var jsonDict = [String: Any]()
        
        jsonDict["status"] = data.status
        
        jsonDict["element"] = data.element.json
        
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

extension ToDoItemElement: Deserialization {
    static func deserialize(from data: Data) throws -> ToDoItemElement? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let status = json["status"] as? String,
               let element = json["element"] as? [String: Any],
               let revision = json["revision"] as? Int32? {
                
                guard let todoItem = ToDoItem.parse(json: element) else {
                    throw APIError.parseError
                }

                let response = ToDoItemElement(status: status, element: todoItem, revision: revision)
                return response
            }
        } catch {
            print(error)
        }
        return nil
    }
}
