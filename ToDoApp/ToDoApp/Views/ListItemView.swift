//
//  ListItemView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 29.06.2024.
//

import SwiftUI
import FileCache

struct ListItemView: View {
    @Binding var item: ToDoItem
    @ObservedObject var viewModel: TodoListViewModel

    var body: some View {
        HStack {
            HStack {
                Button {
                    withAnimation {
                        viewModel.doneButtonToggle(item)
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
                    } else {
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

                VStack(alignment: .leading) {
                    HStack {
                        if item.importance == .important {
                            Image(systemName: T.exclamationMark)
                                .foregroundStyle(C.red.swiftUIColor)
                        } else if item.importance == .low {
                            Image(systemName: T.arrowDown)
                                .foregroundStyle(C.gray.swiftUIColor)
                        }

                        Text(item.text)
                            .foregroundStyle(item.isDone ? C.labelTertiary.swiftUIColor:  C.labelPrimary.swiftUIColor)
                            .strikethrough(item.isDone)
                            .lineLimit(3)
                    }

                    if let deadline = item.deadline {
                        HStack(spacing: 2) {
                            Image(systemName: "calendar")

                            Text(DateFormatterManager.shared.dateFormatter().string(from: deadline))
                                .font(.footnote)
                            }
                                .foregroundStyle(C.labelTertiary.swiftUIColor)
                        }
                }
                .padding(.vertical, 20)
            }

            Spacer()

            Button {
                viewModel.editItem.toggle()
                viewModel.itemToEdit = item
            } label: {
                Image(systemName: "arrow.right")
                    .foregroundStyle(C.labelTertiary.swiftUIColor)
            }
            .buttonStyle(.borderless)

            Rectangle()
                .fill(Color(uiColor: UIColor.init(hex: item.color ?? "") ?? .blue))
                .frame(width: Constants.coloredRectangleWidth)
        }
        .swipeActions(edge: .leading) {
            Button {
                withAnimation {
                    viewModel.doneButtonToggle(item)
                }
            } label: {
                Circle()
                    .fill(C.white.swiftUIColor)
                    .overlay(
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(C.green.swiftUIColor)
                    )
            }
            .tint(C.green.swiftUIColor)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                withAnimation {
                    viewModel.removeTask(item.id)
                }
            } label: {
                Circle()
                    .fill(C.white.swiftUIColor)
                    .overlay(
                        Image(systemName: "trash.fill")
                            .foregroundColor(C.white.swiftUIColor)
                    )
            }
            .tint(C.red.swiftUIColor)
        }
        .swipeActions(edge: .trailing) {
            Button {

            } label: {
                Circle()
                    .fill(C.white.swiftUIColor)
                    .overlay(
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(C.white.swiftUIColor)
                    )
            }
            .tint(C.grayLight.swiftUIColor)
        }
    }
}

#Preview {
    @State var item = ToDoItem(text: "Купить что-то", importance: .basic, isDone: true)
    @State var count = 0
    @State var viewModel = TodoListViewModel()
    return ListItemView(item: $item, viewModel: viewModel)
}
