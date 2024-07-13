//  Created by Elina Karapetian on 22.06.2024.

import SwiftUI

struct MainView: View {
    @State var createItem = false
    @State var showAllItems = false
    @ObservedObject var viewModel = TodoListViewModel()

    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    Color(C.backPrimary.swiftUIColor)
                        .ignoresSafeArea()

                    List {
                        Section(header: HStack {
                            Text("Выполнено — \(viewModel.countDoneItems)")
                                .foregroundStyle(C.labelTertiary.swiftUIColor)

                            Spacer()

                            Button {
                                showAllItems.toggle()
                            } label: {
                                Text(showAllItems ? "Скрыть": "Показать")
                                    .foregroundStyle(C.blue.swiftUIColor)
                            }
                        }
                            .textCase(nil)
                            .listRowInsets(EdgeInsets())
                            .padding(.bottom, 5)) {
                                ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                                    if showAllItems {
                                        ListItemView(item: $viewModel.items[index], viewModel: viewModel)
                                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                    } else {
                                        if !item.isDone {
                                            ListItemView(item: $viewModel.items[index], viewModel: viewModel)
                                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                                        }
                                    }
                                }

                                NewItemCell(createItem: $createItem)
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(C.backSecondary.swiftUIColor)

                }
                .ignoresSafeArea(edges: .bottom)
                .sheet(isPresented: $createItem) {
                    CreateEditItemView(
                        viewModel: CreateItemViewViewModel(todoListViewModel: viewModel),
                        actionType: .create
                    )
                }
                .sheet(isPresented: $viewModel.editItem) {
                    CreateEditItemView(
                        viewModel: CreateItemViewViewModel(
                            todoItem: viewModel.itemToEdit,
                            todoListViewModel: viewModel
                        ),
                        actionType: .edit
                    )
                }
                .navigationTitle("Мои дела")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CalendarViewControllerRep {
                            viewModel.uploadItems()
                        }.navigationBarTitle("Мои дела").navigationBarTitleDisplayMode(.inline).ignoresSafeArea()) {
                            Image(systemName: "calendar")
                        }
                    }
                }
            }

            VStack {
                Spacer()

                Button {
                    createItem.toggle()
                } label: {
                    Image(systemName: T.plus)
                        .resizable()
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(C.blue.swiftUIColor)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
