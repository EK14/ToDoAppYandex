//
//  ToDoItem+Extension.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 19.07.2024.
//

import Foundation
import FileCache

extension ToDoItem: Deserialization {
    static func deserialize(from data: Data) throws -> ToDoItem? {
        ToDoItem.createItem(data: data)
    }
}

extension ToDoItem: Serialization {
    static func serialize(_ data: ToDoItem) -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data.json, options: [])
            return jsonData
        } catch {
            print("Error encoding model: \(error)")
        }
        return nil
    }
}
