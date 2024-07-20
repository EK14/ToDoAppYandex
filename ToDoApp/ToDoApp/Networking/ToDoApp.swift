//
//  ToDoApp.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation

enum ToDoApp {
    enum Headers {
        static let headers: [String: String] = [
            "Authorization": "Bearer \(Bundle.main.object(forInfoDictionaryKey: "Password") as? String ?? "")",
        ]
    }
    
    static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
    
    enum Path {
        static let itemList = "/list"
    }
}
