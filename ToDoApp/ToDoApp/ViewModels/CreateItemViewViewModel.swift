//
//  CreateItemViewViewModel.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 26.06.2024.
//

import Foundation

class CreateItemViewViewModel: ObservableObject {
    @Published var text: String
    @Published var height: CGFloat
    @Published var importance = ItemImportance.basic
    @Published var isOn = false
    @Published var date = Date.now.addingTimeInterval(86400)
    
    init(
        text: String = "",
        height: CGFloat = Constants.textViewDefaultHeight
    ) {
        self.text = text
        self.height = height
    }
}
