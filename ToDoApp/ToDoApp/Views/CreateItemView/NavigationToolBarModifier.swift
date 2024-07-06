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
    var actionType: ItemActionType
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(T.item)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        switch actionType {
                        case .edit:
                            viewModel.update()
                        case .create:
                            viewModel.save()
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(T.save)
                    }
                    .disabled(viewModel.text.isEmpty)
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
