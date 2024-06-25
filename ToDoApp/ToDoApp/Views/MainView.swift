//  Created by Elina Karapetian on 22.06.2024.

import SwiftUI

struct MainView: View {
    @State var createItem = false
    
    var body: some View {
        ZStack {
            Color("BackPrimary")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Button {
                    createItem.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                        .shadow(radius: 20)
                }
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $createItem, content: {
                CreateItemView()
            })
        }
    }
}

#Preview {
    MainView()
}
