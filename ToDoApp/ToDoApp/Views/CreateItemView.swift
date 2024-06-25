//  Created by Elina Karapetian on 15.06.2024.

import SwiftUI

struct CreateItemView: View {
    @State var text = ""
    @State var height: CGFloat = 120.0
    var body: some View {
        NavigationStack {
            ZStack {
                Color(C.backPrimary.color)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        ZStack(alignment: .topLeading) {
                            CustomTextView(text: $text, height: $height, placeholder: T.whatNeedToDo)
                                .cornerRadius(16)
                            
                            if text.isEmpty {
                                Text(T.whatNeedToDo)
                                    .frame(alignment: .leading)
                                    .padding(.leading, 20)
                                    .padding(.top, 17)
                                    .foregroundColor(C.labelTertiary.swiftUIColor)
                            }
                        }
                        .frame(height: height)
                        .padding(.bottom, UIScreen.main.bounds.size.height * 0.03)
                        .padding(.horizontal, UIScreen.main.bounds.size.height * 0.02)
                    }
                }
            }
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
                        
                    } label: {
                        Text(T.cancel)
                    }
                    .disabled(true)
                }
            }
        }
    }
}

#Preview {
    CreateItemView()
}
