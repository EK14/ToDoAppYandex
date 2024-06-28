//  Created by Elina Karapetian on 22.06.2024.

import SwiftUI

struct MainView: View {
    @State var createItem = false
    @ObservedObject var viewModel = CreateItemViewViewModel()
    
    var body: some View {
        ZStack {
            Color(C.backPrimary.swiftUIColor)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Button {
                    createItem.toggle()
                } label: {
                    Image(systemName: T.plus)
                        .resizable()
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(C.blue.swiftUIColor)
                        .clipShape(Circle())
                        .shadow(radius: 20)
                }
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $createItem, content: {
                CreateItemView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    MainView()
}
