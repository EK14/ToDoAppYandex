//
//  CalendarViewModel.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 06.07.2024.
//

import Foundation
import CocoaLumberjackSwift

class CalendarViewModel: ObservableObject {
    var fileCache = FileCache.shared
    
    var items = [ToDoItem]()
    
    var days = [String]()

    var sectionData = [[ToDoItem]]()
    
    func uploadItems() {
        fileCache.upload()
        items = fileCache.todoItems
        DDLogInfo("Tasks uploaded")
    }
    
    func doneButtonToggle(_ item: ToDoItem, isDone: Bool) {
        let item = ToDoItem(
            id: item.id,
            text: item.text,
            importance: item.importance,
            deadline: item.deadline,
            isDone: isDone,
            createdAt: item.createdAt,
            changedAt: item.changedAt,
            color: item.color
        )
        fileCache.removeTask(item.id)
        fileCache.addTask(item)
        fileCache.save()
        uploadItems()
        DDLogInfo("Task with ID \(item.id) toggled done status to \(isDone)")
    }
}
