//
//  ColorPicker.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ColorPicker(T.color, selection: $color, supportsOpacity: false)
            
            Text(color.toHexString()!)
                .foregroundStyle(C.blue.swiftUIColor)
                .font(.footnote)
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(C.backSecondary.swiftUIColor)
        .cornerRadius(Constants.cornerRadius, corners: [.bottomRight, .bottomLeft])
        .padding(.horizontal, Constants.horizontalPadding)
    }
}
