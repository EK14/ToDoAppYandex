//  Created by Elina Karapetian on 24.06.2024.

import SwiftUI
import Combine
import CocoaLumberjackSwift
import FileCache

class TodoListViewModel: ObservableObject {
    @Published var items = [ToDoItem]()
    @Published var editItem = false
    @Published var itemToEdit: ToDoItem?
//    var fileCache = FileCache.shared

    init() {
        uploadItems()
    }

    var countDoneItems: Int {
        items.filter { $0.isDone }.count
    }

    func removeTask(_ taskID: String) {
        items.removeAll(where: { $0.id == taskID })
//        fileCache.removeTask(taskID)
//        fileCache.save()
        Task { await DefaultNetworkingService.shared.deleteToDoItem(taskID) }
        DDLogInfo("Task with ID \(taskID) removed")
    }

    func saveItem(_ item: ToDoItem) {
        items.append(item)
//        fileCache.addTask(item)
//        fileCache.save()
        Task { await DefaultNetworkingService.shared.addToDoItem(item) }
        DDLogInfo("Task with ID \(item.id) saved")
    }

    func uploadItems() {
//        fileCache.upload()
//        items = fileCache.todoItems
        Task {
            let result = await DefaultNetworkingService.shared.getItemsList()
            DispatchQueue.main.async {
                self.items = result
            }
        }
        DDLogInfo("Tasks uploaded")
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
//        fileCache.removeTask(item.id)
//        fileCache.addTask(item)
//        fileCache.save()
        Task {
            await DefaultNetworkingService.shared.updateToDoItem(item)
            uploadItems()
        }
        DDLogInfo("Task with ID \(item.id) toggled done status")
    }

    func updateItem(_ item: ToDoItem) {
//        fileCache.removeTask(item.id)
//        fileCache.addTask(item)
//        fileCache.save()
        Task {
            await DefaultNetworkingService.shared.updateToDoItem(item)
            uploadItems()
        }
        DDLogInfo("Task with ID \(item.id) updated")
    }
}
