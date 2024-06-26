//
//  ContentView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 29.06.2024.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var pickerSelection = 0
    
    var body: some View {
        VStack {
            FrequentlyUpdatedView(counter: $counter)
                .onReceive(timer) {
                    self.counter += 1
                    print($0)
            }
            
            Picker("Snappy Picker", selection: $pickerSelection) {
                ForEach(0..<8) { i in
                    Text("Item \(i)")
                }
            }
            .labelsHidden()
        }
    }
}

struct FrequentlyUpdatedView: View {
    @Binding fileprivate var counter: Int
    
    var body: some View {
        Text("Counter: \(counter)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
