//
//  TextView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct TextView: View {
    @Binding var text: String
    @Binding var height: CGFloat
    @Binding var color: Color
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            CustomTextView(text: $text, height: $height, placeholder: T.whatNeedToDo)
                .textEditorBackground {
                    ZStack(alignment: .trailing) {
                        Color.clear
                            .background(C.backSecondary.swiftUIColor)
                        
                        Rectangle()
                            .fill(color)
                            .frame(width: Constants.coloredRectangleWidth)
                    }
                }
                .cornerRadius(Constants.cornerRadius)
            
            if text.isEmpty {
                Text(T.whatNeedToDo)
                    .frame(alignment: .leading)
                    .padding(.leading, Constants.textViewTextContainerInset.left)
                    .padding(.top, Constants.textViewTextContainerInset.top)
                    .foregroundColor(C.labelTertiary.swiftUIColor)
            }
        }
        .frame(height: height)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.top, Constants.topPadding)
    }
}
