//  Created by Elina Karapetian on 24.06.2024.

import SwiftUI

class MainViewViewModel: ObservableObject {
    @Published var items = [ToDoItem(text: "Купить что-то", importance: .basic, isDone: true)]

    var countDoneItems: Int {
        items.filter { $0.isDone }.count
    }

    func removeTask(_ taskID: String) {
        items.removeAll(where: { $0.id == taskID })
    }
}
