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
