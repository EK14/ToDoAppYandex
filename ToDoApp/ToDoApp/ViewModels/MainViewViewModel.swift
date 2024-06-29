//  Created by Elina Karapetian on 24.06.2024.

import SwiftUI
import Combine

class MainViewViewModel: ObservableObject {
    @Published var items = [ToDoItem]()

    var countDoneItems: Int {
        items.filter { $0.isDone }.count
    }

    func removeTask(_ taskID: String) {
        items.removeAll(where: { $0.id == taskID })
    }
    
    func showDoneItems() {
        
    }
}
