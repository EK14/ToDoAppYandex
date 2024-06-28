//
//  DeadlineSegmentView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct DeadlineSegmentView: View {
    @Binding var isOn: Bool
    @Binding var datePickerIsHidden: Bool
    @Binding var date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(T.doBefore)
                
                if isOn {
                    Button {
                        withAnimation {
                            datePickerIsHidden.toggle()
                        }
                    } label: {
                        Text(DateFormatterManager.shared.dateFormatter().string(from: date))
                            .foregroundStyle(C.blue.swiftUIColor)
                            .font(.footnote)
                    }
                }
            }
            
            Spacer()
            
            Toggle(isOn: $isOn) {}
                .onChange(of: isOn) {
                    if !isOn {
                        withAnimation {
                            datePickerIsHidden = true
                        }
                    }
                }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(C.backSecondary.swiftUIColor)
        .padding(.horizontal, Constants.horizontalPadding)
    }
}
