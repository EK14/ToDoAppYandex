//  Created by Elina Karapetian on 26.06.2024.

import SwiftUI

class CreateItemViewViewModel: ObservableObject {
    private let fileCache = FileCache(fileName: "myItems")
    @Published var height: CGFloat = Constants.textViewDefaultHeight
    @Published var isOn = false
    @Published var datePickerIsHidden = true
    @Published var color = C.red.swiftUIColor
    @Published var item = ToDoItem(
        text: "",
        importance: .basic,
        isDone: false,
        color: C.red.color.toHexString() ?? ""
    )
    
    func save() {
        item.color = color.toHexString() ?? ""
        fileCache.addTask(item)
        fileCache.save()
        print(item)
        // save function
    }
    
    func delete() {
        self.item.text = ""
        self.height = Constants.textViewDefaultHeight
        self.item.importance = ItemImportance.basic
        self.isOn = false
        self.item.deadline = nil
        self.datePickerIsHidden = true
    }
}
