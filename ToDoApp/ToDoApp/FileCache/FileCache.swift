//  Created by Elina Karapetian on 16.06.2024.

import Foundation

class FileCache {
    private(set) var todoItems: [ToDoItem] = []
    private var appFolderPath: URL = URL(filePath: "")
    private let manager = FileManager.default
    private var fileName: String
    var saveAction: (() -> Void)?

    static let shared = FileCache()

    private init() {
        self.fileName = "todoappcache"
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        self.appFolderPath = url.appendingPathComponent("todoappyandex")
        print(appFolderPath)
        do {
            try manager.createDirectory(at: appFolderPath, withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addTask(_ todoItem: ToDoItem) {
        if !todoItems.contains(where: { $0.id == todoItem.id }) {
            todoItems.append(todoItem)
        }
    }

    func removeTask(_ taskID: String) {
        todoItems.removeAll(where: { $0.id == taskID })
    }

    func save() {
        let todoItemsData = todoItems.map { $0.json }
        do {
            let fileUrl = appFolderPath.appendingPathComponent("\(fileName).json")
            let jsonData = try JSONSerialization.data(withJSONObject: todoItemsData)
            manager.createFile(atPath: fileUrl.path, contents: jsonData)
        } catch {
            print(error.localizedDescription)
        }
        saveAction?()
    }

    func upload() {
        let fileUrl = appFolderPath.appendingPathComponent("\(fileName).json")
        if let data = try? Data(contentsOf: fileUrl) {
            if let loadedItems = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                todoItems = loadedItems.compactMap { ToDoItem.parse(json: $0) }
            }
        }
    }
}
