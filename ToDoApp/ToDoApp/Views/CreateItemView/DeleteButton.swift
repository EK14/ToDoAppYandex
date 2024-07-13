//
//  DeleteButton.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct DeleteButton: View {
    var actionType: ItemActionType

    var body: some View {
        Button {
            // delete action
        } label: {
            Text(T.delete)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.deleteButtonVerticalPadding)
        .background(C.backSecondary.swiftUIColor)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, Constants.horizontalPadding)
        .foregroundColor(actionType == .create ? C.labelTertiary.swiftUIColor: C.red.swiftUIColor)
        .disabled(actionType == .create)
    }
}
