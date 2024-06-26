//  Created by Elina Karapetian on 15.06.2024.

import SwiftUI

struct CreateItemView: View {
    @ObservedObject var viewModel = CreateItemViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(C.backPrimary.color)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        textView
                        
                        VStack(spacing: 0) {
                            HStack {
                                Text(T.importance)
                                
                                Spacer()
                                
                                importanceSegment
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(C.backSecondary.swiftUIColor)
                            .cornerRadius(16, corners: [.topLeft, .topRight])
                            .padding(.horizontal, 16)
                            
                            Divider()
                                .padding(.horizontal, 32)
                            
                            deadlineSegment
                            
                            if viewModel.isOn {
                                Divider()
                                    .padding(.horizontal, 32)
                                
                                DatePicker(
                                        "",
                                        selection: $viewModel.date,
                                        displayedComponents: [.date]
                                    )
                                    .datePickerStyle(.graphical)
                                    .background(C.backSecondary.swiftUIColor)
                                    .cornerRadius(16, corners: [.bottomRight, .bottomLeft])
                                    .padding(.horizontal, 16)
                                    .environment(\.locale, Locale.init(identifier: "ru"))
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            Text(T.delete)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(C.backSecondary.swiftUIColor)
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .foregroundColor(C.red.swiftUIColor)
                    }
                }
            }
            .navigationTitle(T.item)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        
                    } label: {
                        Text(T.save)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        
                    } label: {
                        Text(T.cancel)
                    }
                }
            }
        }
    }
    
    var textView: some View {
        ZStack(alignment: .topLeading) {
            CustomTextView(text: $viewModel.text, height: $viewModel.height, placeholder: T.whatNeedToDo)
                .textEditorBackground {
                    Color.clear
                        .background(C.backSecondary.swiftUIColor)
                }
                .cornerRadius(Constants.textViewCornerRadius)
            
            if viewModel.text.isEmpty {
                Text(T.whatNeedToDo)
                    .frame(alignment: .leading)
                    .padding(.leading, Constants.textViewTextContainerInset.left)
                    .padding(.top, Constants.textViewTextContainerInset.top)
                    .foregroundColor(C.labelTertiary.swiftUIColor)
            }
        }
        .frame(height: viewModel.height)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.top, Constants.topPadding)
    }
    
    var importanceSegment: some View {
        Picker("", selection: $viewModel.importance) {
            Image(systemName: T.arrowDown)
                .tag(ItemImportance.low)
            Text(T.no)
                .tag(ItemImportance.basic)
            Image(systemName: T.exclamationMark)
                .foregroundStyle(.red, .black)
                .tag(ItemImportance.important)
        }
        .pickerStyle(.segmented)
        .fixedSize()
    }
    
    var deadlineSegment: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(T.doBefore)
                
                if viewModel.isOn {
                    Text(DateFormatterManager.shared.dateFormatter().string(from: viewModel.date))
                    .foregroundStyle(C.blue.swiftUIColor)
                    .font(.footnote)
                }
            }
            
            Spacer()
            
            Toggle(isOn: $viewModel.isOn) {}
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(C.backSecondary.swiftUIColor)
        .cornerRadius(viewModel.isOn ? 0: 16, corners: [.bottomRight, .bottomLeft])
        .padding(.horizontal, 16)
    }
}

#Preview {
    CreateItemView()
}
