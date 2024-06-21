//
//  FileCache.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 16.06.2024.
//

import Foundation

class FileCache {
    private(set) var todoItems: [ToDoItem] = []
    private let filepath: String
    
    init(filename: String) {
        self.filepath = filename
        loadFromFile()
    }

    func addTask(_ todoItem: ToDoItem) {
        if !todoItems.contains(where: { $0.id == todoItem.id }) {
            todoItems.append(todoItem)
            saveToFile()
        }
    }

    func removeTask(_ taskID: String) {
        todoItems.removeAll(where: { $0.id == taskID })
        saveToFile()
    }

    private func saveToFile() {
        let todoItemsData = todoItems.map { $0.json }
        let jsonData = try! JSONSerialization.data(withJSONObject: todoItemsData)
        let url = URL(fileURLWithPath: filepath)
        try? jsonData.write(to: url)
    }

    private func loadFromFile() {
        let url = URL(fileURLWithPath: filepath)
        if let data = try? Data(contentsOf: url) {
            if let loadedItems = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
                todoItems = loadedItems.compactMap { ToDoItem.parse(json: $0) }
            }
        }
    }
}
