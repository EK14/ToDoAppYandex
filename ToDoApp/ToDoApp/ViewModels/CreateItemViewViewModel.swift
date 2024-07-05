//  Created by Elina Karapetian on 26.06.2024.

import SwiftUI

class CreateItemViewViewModel: ObservableObject {
    @Published var height: CGFloat = Constants.textViewDefaultHeight
    @Published var isOn = false
    @Published var datePickerIsHidden = true
    @Published var color = C.red.swiftUIColor
    @Published var todoItem: ToDoItem?
    @Published var text: String
    @Published var importance: ItemImportance
    @Published var deadline: Date?
    
    var todoListViewModel: TodoListViewModel
    
    init(todoItem: ToDoItem? = nil, todoListViewModel: TodoListViewModel) {
        self.todoItem = todoItem
        self.todoListViewModel = todoListViewModel
        self.text = todoItem?.text ?? ""
        self.importance = todoItem?.importance ?? .basic
        self.deadline = todoItem?.deadline ?? nil
        self.datePickerIsHidden = true
        self.color = Color(UIColor(hex: todoItem?.color ?? "F0171") ?? .blue)
    }
    
    func save() {
        let updatedItem = ToDoItem(
            text: text,
            importance: importance,
            deadline: deadline, 
            isDone: todoItem?.isDone ?? false,
            color: color.toHexString(includeAlpha: false)
        )
        todoListViewModel.saveItem(updatedItem)
    }
    
    func delete() {
        guard let todoItem = self.todoItem else { return }
        todoListViewModel.removeTask(todoItem.id)
    }
}
