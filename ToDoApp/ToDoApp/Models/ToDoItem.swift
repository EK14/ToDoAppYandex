//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 15.06.2024.
//

import Foundation

struct ToDoItem {
    let id: String
    let text: String
    let importance: ItemImportance
    let deadline: Date?
    let done: Bool
    let createdAt: Date
    let changedAt: Date?
    
    init(id: String? = UUID().uuidString,
         text: String,
         importance: ItemImportance,
         deadline: Date? = nil,
         done: Bool,
         createdAt: Date,
         changedAt: Date? = nil) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.done = done
        self.createdAt = createdAt
        self.changedAt = changedAt
    }
}

extension ToDoItem {
    // Сomputed property for generating json
    var json: Any {
        var jsonDict: [String: Any] = [
            "text": text,
        ]
        
        jsonDict["id"] = id

        // Don't save importance in json if it's "basic"
        if importance != .basic {
            jsonDict["importance"] = importance.rawValue
        }

        // Save deadline only if it is specified
        if let deadline = deadline {
            jsonDict["deadline"] = deadline
        }
        
        jsonDict["created_at"] = createdAt.timeIntervalSince1970

        jsonDict["done"] = done
        
        return jsonDict
    }
    
    // - Parameter json: A JSON object in the form of a URL or a dictionary
    // - Returns: A ToDoItem object if the JSON is valid, or nil otherwise
    static func parse(json: Any) -> ToDoItem? {
        // Check if the input is a URL or a dictionary
        if let json = json as? URL {
            do {
                let data = try Data(contentsOf: json)
                return ToDoItem.createItem(data: data)
            } catch {
                print(error.localizedDescription)
            }
        } else if let json = json as? [String: Any] {
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
                return nil
            }
            return ToDoItem.createItem(data: data)
        }
        return nil
    }
    
    // - Parameter data: A Data object containing the JSON data
    // - Returns: A ToDoItem instance if the JSON data is valid and contains all required fields, or nil otherwise
    private static func createItem(data: Data) -> ToDoItem? {
        guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        let id = jsonDict["id"] as? String
        
        guard let text = jsonDict["text"] as? String,
              let createdAt = jsonDict["created_at"] as? TimeInterval,
              let importanceString = jsonDict["importance"] as? String,
              let importance = ItemImportance(rawValue: importanceString) else {
            return nil
        }
        
        let deadline = jsonDict["deadline"] as? TimeInterval
        
        let done = jsonDict["done"] as? Bool ?? false
        
        let changedAt = jsonDict["changed_at"] as? TimeInterval
        
        return ToDoItem(id: id, text: text, importance: importance, deadline: deadline.map { Date(timeIntervalSince1970: $0) }, done: done, createdAt: Date(timeIntervalSince1970: createdAt), changedAt: changedAt.map { Date(timeIntervalSince1970: $0) })
    }
}

