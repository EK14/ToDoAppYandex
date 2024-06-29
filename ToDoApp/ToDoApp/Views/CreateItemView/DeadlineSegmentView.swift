//
//  DeadlineSegmentView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 28.06.2024.
//

import SwiftUI

struct DeadlineSegmentView: View {
    @Binding var isOn: Bool
    @Binding var date: Date?
    @Binding var datePickerIsHidden: Bool
    
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
                        Text(DateFormatterManager.shared.dateFormatter().string(from: date ?? Date.now.addingTimeInterval(86400)))
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
                    } else {
                        date = Date.now.addingTimeInterval(86400)
                    }
                }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(C.backSecondary.swiftUIColor)
        .padding(.horizontal, Constants.horizontalPadding)
    }
}
