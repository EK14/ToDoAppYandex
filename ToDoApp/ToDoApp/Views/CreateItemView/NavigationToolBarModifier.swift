//
//  NavigationToolBarModifier.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct NavigationToolBarModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CreateItemViewViewModel
    @ObservedObject var mainViewViewModel: MainViewViewModel
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(T.item)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        viewModel.save()
                        mainViewViewModel.items.append(viewModel.item)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(T.save)
                    }
                    .disabled(viewModel.item.text.isEmpty ? true: false)
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
