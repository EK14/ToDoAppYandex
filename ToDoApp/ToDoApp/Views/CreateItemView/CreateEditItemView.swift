//  Created by Elina Karapetian on 15.06.2024.

import SwiftUI

struct CreateEditItemView: View {
    @ObservedObject var viewModel = CreateItemViewViewModel()
    @ObservedObject var mainViewViewModel: MainViewViewModel
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
                            TextView(text: $viewModel.item.text, height: $viewModel.height, color: $viewModel.color)

                            SettingsView(importance: $viewModel.item.importance,
                                         isOn: $viewModel.isOn,
                                         date: $viewModel.item.deadline,
                                         color: $viewModel.color, datePickerIsHidden: $viewModel.datePickerIsHidden)

                            DeleteButton(actionType: actionType)
                        }
                    }
                }
                .modifier(NavigationToolBarModifier(viewModel: viewModel, mainViewViewModel: mainViewViewModel))
            } else {
                ZStack {
                    Color(C.backPrimary.color)
                        .edgesIgnoringSafeArea(.all)
                    ScrollView {
                        VStack(spacing: Constants.verticalStackSpacing) {
                            HStack(alignment: .top) {
                                TextView(text: $viewModel.item.text, height: $viewModel.height, color: $viewModel.color)

                                SettingsView(importance: $viewModel.item.importance,
                                             isOn: $viewModel.isOn,
                                             date: $viewModel.item.deadline,
                                             color: $viewModel.color, datePickerIsHidden: $viewModel.datePickerIsHidden)
                                .padding(.top, 16)
                            }
                            
                            DeleteButton(actionType: actionType)
                        }
                    }
                }
                .modifier(NavigationToolBarModifier(viewModel: viewModel, mainViewViewModel: mainViewViewModel))
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
    @State private var showColorPicker = false

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
        .sheet(isPresented: $showColorPicker, content: {
            ColorPickerView(color: $color)
        })
    }
}
