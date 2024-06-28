//
//  CreateItemViewViewModel.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 26.06.2024.
//

import SwiftUI

class CreateItemViewViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var height: CGFloat = Constants.textViewDefaultHeight
    @Published var importance = ItemImportance.basic
    @Published var isOn = false
    @Published var datePickerIsHidden = true
    @Published var date = Date.now.addingTimeInterval(86400)
    @Published var color = Color.red
    
    func save() {
        
    }
    
    func delete() {
        self.text = ""
        self.height = Constants.textViewDefaultHeight
        self.importance = ItemImportance.basic
        self.isOn = false
        self.datePickerIsHidden = true
        self.date = Date.now.addingTimeInterval(86400)
    }
}
