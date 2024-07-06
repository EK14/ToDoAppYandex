//  Created by Elina Karapetian on 24.06.2024.

import SwiftUI
import Combine

class TodoListViewModel: ObservableObject {
    @Published var items = [ToDoItem]()
    @Published var editItem = false
    @Published var itemToEdit: ToDoItem?
    var fileCache = FileCache.shared
    
    init() {
        uploadItems()
    }

    var countDoneItems: Int {
        items.filter { $0.isDone }.count
    }

    func removeTask(_ taskID: String) {
        items.removeAll(where: { $0.id == taskID })
        fileCache.removeTask(taskID)
        fileCache.save()
    }
    
    func saveItem(_ item: ToDoItem) {
        items.append(item)
        fileCache.addTask(item)
        fileCache.save()
    }
    
    func uploadItems() {
        fileCache.upload()
        items = fileCache.todoItems
    }
    
    func doneButtonToggle(_ item: ToDoItem) {
        let item = ToDoItem(
            id: item.id,
            text: item.text,
            importance: item.importance,
            deadline: item.deadline,
            isDone: !item.isDone, 
            createdAt: item.createdAt,
            changedAt: item.changedAt,
            color: item.color
        )
        fileCache.removeTask(item.id)
        fileCache.addTask(item)
        fileCache.save()
        uploadItems()
    }
    
    func updateItem(_ item: ToDoItem) {
        let item = ToDoItem(
            id: item.id,
            text: item.text,
            importance: item.importance,
            deadline: item.deadline,
            isDone: item.isDone,
            createdAt: item.createdAt,
            changedAt: item.changedAt,
            color: item.color
        )
        fileCache.removeTask(item.id)
        fileCache.addTask(item)
        fileCache.save()
        uploadItems()
    }
}
