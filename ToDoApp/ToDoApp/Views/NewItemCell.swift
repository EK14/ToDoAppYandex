//
//  NewItemCell.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 29.06.2024.
//

import SwiftUI

struct NewItemCell: View {
    @Binding var createItem: Bool
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 24, height: 24)
                .opacity(0)
            
            Text("Новое")
                .foregroundStyle(C.labelTertiary.swiftUIColor)
        }
        .onTapGesture {
            createItem.toggle()
        }
    }
}

#Preview {
    @State var createItem = false
    
    return NewItemCell(createItem: $createItem)
}
