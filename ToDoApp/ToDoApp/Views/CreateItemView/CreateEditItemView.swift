//  Created by Elina Karapetian on 15.06.2024.

import SwiftUI

struct CreateEditItemView: View {
    @ObservedObject var viewModel: CreateItemViewViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    var actionType: ItemActionType

    var body: some View {
        NavigationStack {
            if verticalSizeClass == .regular {
                ZStack {
                    Color(C.backPrimary.color)
                        .edgesIgnoringSafeArea(.all)

                    ScrollView {
                        VStack(spacing: Constants.verticalStackSpacing) {
                            TextView(text: $viewModel.text, height: $viewModel.height, color: $viewModel.color)

                            SettingsView(importance: $viewModel.importance,
                                         isOn: $viewModel.isOn,
                                         date: $viewModel.deadline,
                                         color: $viewModel.color,
                                         datePickerIsHidden: $viewModel.datePickerIsHidden,
                                         category: $viewModel.category,
                                         categoryColor: $viewModel.categoryColor)

                            DeleteButton(actionType: actionType)
                        }
                    }
                }
                .modifier(NavigationToolBarModifier(viewModel: viewModel, actionType: actionType))
            } else {
                ZStack {
                    Color(C.backPrimary.color)
                        .edgesIgnoringSafeArea(.all)
                    ScrollView {
                        VStack(spacing: Constants.verticalStackSpacing) {
                            HStack(alignment: .top) {
                                TextView(text: $viewModel.text, height: $viewModel.height, color: $viewModel.color)

                                SettingsView(importance: $viewModel.importance,
                                             isOn: $viewModel.isOn,
                                             date: $viewModel.deadline,
                                             color: $viewModel.color,
                                             datePickerIsHidden: $viewModel.datePickerIsHidden,
                                             category: $viewModel.category,
                                             categoryColor: $viewModel.categoryColor)
                                .padding(.top, 16)
                            }

                            DeleteButton(actionType: actionType)
                        }
                    }
                }
                .modifier(NavigationToolBarModifier(viewModel: viewModel, actionType: actionType))
            }
        }
    }
}

struct SettingsView: View {
    @Binding var importance: ItemImportance
    @Binding var isOn: Bool
    @Binding var date: Date?
    @Binding var color: Color
    @Binding var datePickerIsHidden: Bool
    @Binding var category: String
    @Binding var categoryColor: Color
    @State private var showColorPicker = false

//    @State private var selectedCategory = ItemCategory.other.rawValue
    @State var showCategoryPicker = false

    var body: some View {
        VStack(spacing: .zero) {
            ImportanceSegmentView(importance: $importance)

            Divider()
                .padding(.horizontal, Constants.dividerHorizontalPadding)

            DeadlineSegmentView(isOn: $isOn, date: $date, datePickerIsHidden: $datePickerIsHidden)

            if !datePickerIsHidden {
                Divider()
                    .padding(.horizontal, Constants.dividerHorizontalPadding)

                DatePickerView(date: $date, datePickerIsHidden: $datePickerIsHidden)
            }

            Divider()
                .padding(.horizontal, Constants.dividerHorizontalPadding)

            HStack {
                Text("Категория")

                Spacer()

                Button {
                    showCategoryPicker.toggle()
                } label: {
                    HStack {
                        Text(category)
                        Image(systemName: "arrow.right")
                    }
                }

            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background(C.backSecondary.swiftUIColor)
            .padding(.horizontal, Constants.horizontalPadding)

            Divider()
                .padding(.horizontal, Constants.dividerHorizontalPadding)

            HStack {
                VStack(alignment: .leading) {
                    Text("Цвет")

                    Text(color.toHexString()!)
                        .foregroundStyle(C.blue.swiftUIColor)
                        .font(.footnote)
                }

                Spacer()

                Button {
                    showColorPicker.toggle()
                } label: {
                    Text("Выбрать")
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background(C.backSecondary.swiftUIColor)
            .cornerRadius(Constants.cornerRadius, corners: [.bottomLeft, .bottomRight])
            .padding(.horizontal, Constants.horizontalPadding)

        }
        .sheet(isPresented: $showColorPicker) {
            ColorPickerView(color: $color)
        }
        .sheet(isPresented: $showCategoryPicker) {
            PickItemCategoryView(selectedCategory: $category, categoryColor: $categoryColor)
        }
    }
}
