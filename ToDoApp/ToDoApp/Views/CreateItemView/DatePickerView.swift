//
//  DatePickerView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @Binding var datePickerIsHidden: Bool
    
    var body: some View {
        DatePicker(
            "",
            selection: $date,
            in: Date.now.addingTimeInterval(86400)...,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .background(C.backSecondary.swiftUIColor)
        .padding(.horizontal, 16)
        .environment(\.locale, Locale.init(identifier: "ru"))
        .onChange(of: date) {
            withAnimation {
                datePickerIsHidden = true
            }
        }
    }
}
