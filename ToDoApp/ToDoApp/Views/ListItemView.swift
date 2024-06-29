//
//  ListItemView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 29.06.2024.
//

import SwiftUI

struct ListItemView: View {
    @Binding var item: ToDoItem
    @Binding var countDoneItems: Int
    
    var body: some View {
        HStack {
            HStack {
                Button {
                    item.isDone.toggle()
                    if item.isDone {
                        countDoneItems += 1
                    } else {
                        countDoneItems -= 1
                    }
                } label: {
                    if item.isDone {
                        Circle()
                            .fill(C.green.swiftUIColor)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .padding()
                            )
                    } else if item.importance == .important {
                        Circle()
                            .fill(C.red.swiftUIColor.opacity(0.1))
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .stroke(C.red.swiftUIColor, lineWidth: 1.5)
                                    .frame(width: 24, height: 24)
                            )
                    }
                    else {
                        Circle()
                            .fill(.clear)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .stroke(C.labelTertiary.swiftUIColor, lineWidth: 1.5)
                                    .frame(width: 24, height: 24)
                            )
                    }
                }
                .buttonStyle(.borderless)
                
                HStack {
                    if item.importance == .important {
                        Image(systemName: T.exclamationMark)
                            .foregroundStyle(C.red.swiftUIColor)
                    }
                    
                    Text(item.text)
                        .foregroundStyle(item.isDone ? C.labelTertiary.swiftUIColor:  C.labelPrimary.swiftUIColor)
                        .strikethrough(item.isDone)
                }
            }
            
            Spacer()

            Button{
                print("hello")
            } label: {
                Image(systemName: "arrow.right")
                    .foregroundStyle(C.labelTertiary.swiftUIColor)
            }
            .buttonStyle(.borderless)
        }
        .swipeActions(edge: .leading) {
            Button {
             
            } label: {
                Circle()
                    .fill(C.white.swiftUIColor)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Image(systemName: "checkmark")
                            .foregroundColor(C.green.swiftUIColor)
                            .padding()
                    )
            }
            .tint(C.green.swiftUIColor)
        }
    }
}

#Preview {
    @State var item = ToDoItem(text: "Купить что-то", importance: .basic, isDone: true)
    @State var count = 0
    return ListItemView(item: $item, countDoneItems: $count)
}
