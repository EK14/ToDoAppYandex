//
//  ImportanceSegmentView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct ImportanceSegmentView: View {
    @Binding var importance: ItemImportance
    
    var body: some View {
        HStack {
            Text(T.importance)
            
            Spacer()
            
            Picker("", selection: $importance) {
                Image(systemName: T.arrowDown)
                    .tag(ItemImportance.low)
                Text(T.no)
                    .tag(ItemImportance.basic)
                Image(systemName: T.exclamationMark)
                    .foregroundStyle(.red, .red)
                    .tag(ItemImportance.important)
            }
            .pickerStyle(.segmented)
            .fixedSize()
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(C.backSecondary.swiftUIColor)
        .cornerRadius(Constants.cornerRadius, corners: [.topLeft, .topRight])
        .padding(.horizontal, Constants.horizontalPadding)
    }
}
