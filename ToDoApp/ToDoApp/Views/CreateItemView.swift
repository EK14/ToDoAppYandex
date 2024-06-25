//  Created by Elina Karapetian on 15.06.2024.

import SwiftUI

struct CreateItemView: View {
    @State var text = ""
    @State var height: CGFloat = 120.0
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackPrimary")
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        ZStack(alignment: .topLeading) {
                            CustomTextView(text: $text, height: $height, placeholder: "Что надо сделать?")
                                .cornerRadius(16)
                            
                            if text.isEmpty {
                                Text("Что надо сделать?")
                                    .frame(alignment: .leading)
                                    .padding(.leading, 20)
                                    .padding(.top, 17)
                                    .foregroundStyle(Color("LabelTertiary"))
                            }
                        }
                        .frame(height: height)
                        .padding(.bottom, UIScreen.main.bounds.size.height * 0.03)
                        .padding(.horizontal, UIScreen.main.bounds.size.height * 0.02)
                    }
                }
            }
            .navigationTitle("Дело")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        
                    } label: {
                        Text("Сохранить")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        
                    } label: {
                        Text("Отменить")
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
