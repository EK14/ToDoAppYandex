//  Created by Elina Karapetian on 24.06.2024.

import SwiftUI

class MainViewViewModel: ObservableObject {
    @Published var countDoneItems = 0
    @Published var items = [ToDoItem]()
}
