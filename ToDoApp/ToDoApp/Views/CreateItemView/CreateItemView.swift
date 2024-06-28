//  Created by Elina Karapetian on 15.06.2024.

import SwiftUI

struct CreateItemView: View {
    @ObservedObject var viewModel: CreateItemViewViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            if verticalSizeClass == .regular {
                ZStack {
                    Color(C.backPrimary.color)
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            TextView(text: $viewModel.text, height: $viewModel.height, color: $viewModel.color)
                            
                            VStack(spacing: .zero) {
                                ImportanceSegmentView(importance: $viewModel.importance)
                                
                                Divider()
                                    .padding(.horizontal, 32)
                                
                                DeadlineSegmentView(isOn: $viewModel.isOn, datePickerIsHidden: $viewModel.datePickerIsHidden, date: $viewModel.date)
                                
                                if !viewModel.datePickerIsHidden {
                                    Divider()
                                        .padding(.horizontal, 32)
                                    
                                    datePicker
                                }
                                
                                Divider()
                                    .padding(.horizontal, 32)
                                
                                ColorPickerView(color: $viewModel.color)
                            }
                            
                            deleteButton
                        }
                    }
                }
                .modifier(NavigationToolBar(viewModel: viewModel))
            } else {
                ZStack {
                    Color(C.backPrimary.color)
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            HStack(alignment: .top) {
                                TextView(text: $viewModel.text, height: $viewModel.height, color: $viewModel.color)
                                
                                VStack(spacing: .zero) {
                                    ImportanceSegmentView(importance: $viewModel.importance)
                                    
                                    Divider()
                                        .padding(.horizontal, 32)
                                    
                                    DeadlineSegmentView(isOn: $viewModel.isOn, datePickerIsHidden: $viewModel.datePickerIsHidden, date: $viewModel.date)
                                    
                                    if !viewModel.datePickerIsHidden {
                                        Divider()
                                            .padding(.horizontal, 32)
                                        
                                        datePicker
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal, 32)
                                    
                                    ColorPickerView(color: $viewModel.color)
                                }
                                .padding(.top, 16)
                            }
                        }
                    }
                }
                .modifier(NavigationToolBar(viewModel: viewModel))
            }
        }
    }
    
    var datePicker: some View {
        DatePicker(
            "",
            selection: $viewModel.date,
            in: Date.now.addingTimeInterval(86400)..., 
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .background(C.backSecondary.swiftUIColor)
        .padding(.horizontal, 16)
        .environment(\.locale, Locale.init(identifier: "ru"))
        .onChange(of: viewModel.date) {
            withAnimation {
                viewModel.datePickerIsHidden = true
            }
        }
    }
    
    var deleteButton: some View {
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

struct NavigationToolBar: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CreateItemViewViewModel
    
    func body(content: Content) -> some View {
        content
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
                        presentationMode.wrappedValue.dismiss()
                        viewModel.delete()
                    } label: {
                        Text(T.cancel)
                    }
                }
            }
    }
}
