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
                        .ignoresSafeArea()

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
                .modifier(NavigationToolBarModifier(viewModel: viewModel))
            } else {
                ZStack {
                    Color(C.backPrimary.color)
                        .ignoresSafeArea()
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
                        }
                    }
                }
                .modifier(NavigationToolBarModifier(viewModel: viewModel))
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

            ColorPickerView(color: $color)
        }
    }
}
