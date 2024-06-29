//  Created by Elina Karapetian on 22.06.2024.

import SwiftUI

struct MainView: View {
    @State var createItem = false
    @ObservedObject var viewModel = MainViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(C.backPrimary.swiftUIColor)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Выполнено — \(viewModel.countDoneItems)")
                            .foregroundStyle(C.labelTertiary.swiftUIColor)
                        
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Text("Показать")
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    List {
                        ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                            ListItemView(item: $viewModel.items[index], deleteAction: viewModel.removeTask(_:))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(C.backSecondary.swiftUIColor)

                    
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
                    CreateEditItemView(mainViewViewModel: viewModel, actionType: .create)
                })
                .navigationTitle("Мои дела")
            }
        }
    }
}

#Preview {
    MainView()
}
