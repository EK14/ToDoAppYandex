//
//  PickItemCategoryView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 06.07.2024.
//

import SwiftUI

struct PickItemCategoryView: View {
    @State var categories = [
        ItemCategory.work.rawValue,
        ItemCategory.study.rawValue,
        ItemCategory.hobby.rawValue,
        ItemCategory.other.rawValue
    ]
    @State var colors = [
        ItemCategory.work.getColor(),
        ItemCategory.study.getColor(),
        ItemCategory.hobby.getColor(),
        ItemCategory.other.getColor()
    ]
    @Binding var selectedCategory: String
    @Binding var categoryColor: Color
    @State private var isShowingTextField = false
    @State private var newCategory = ""
    @State private var showColorPicker = false
    @State private var showColorAlert = false
    @State private var showCategoryAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(C.backPrimary.swiftUIColor)
                .ignoresSafeArea()
            
            
            List {
                ForEach(Array(categories.enumerated()), id: \.1) { index, item in
                    Button {
                        selectedCategory = item
                        categoryColor = colors[index]
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text(item)
                            
                            Spacer()
                            
                            HStack {
                                if selectedCategory == item {
                                    Image(systemName: "checkmark")
                                }
                                Circle()
                                    .fill(colors[index])
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                }
                
                HStack {
                    TextField(text: $newCategory) {
                        Text("Новая категория")
                    }
                    
                    Button {
                        showColorPicker.toggle()
                    } label: {
                        Text("Цвет")
                            .foregroundStyle(C.labelPrimary.swiftUIColor)
                    }
                    .buttonStyle(.borderless)

                    Circle()
                        .fill(categoryColor)
                        .frame(width: 10, height: 10)
                    
                    Button {
                        if newCategory.isEmpty {
                            showCategoryAlert.toggle()
                        } else if categoryColor == .clear {
                            showColorAlert.toggle()
                        } else if !newCategory.isEmpty {
                            categories.append(newCategory)
                            colors.append(categoryColor)
                        } 
                    } label: {
                        Text("Добавить")
                    }
                    .buttonStyle(.borderless)

                }
            }
            .scrollContentBackground(.hidden)

        }
        .foregroundColor(C.labelPrimary.swiftUIColor)
        .sheet(isPresented: $showColorPicker) {
            ColorPickerView(color: $categoryColor)
        }
        .alert("Пожалуйста, выберите цвет", isPresented: $showColorAlert) {
            Button("OK", role: .cancel) { }
        }
        .alert("Пожалуйста, введите название категории", isPresented: $showCategoryAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}


