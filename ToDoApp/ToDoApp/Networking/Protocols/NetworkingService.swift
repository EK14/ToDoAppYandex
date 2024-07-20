//
//  NetworkingService.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation
import FileCache

protocol NetworkingService {
    func getItemsList() async -> [ToDoItem]
    func addToDoItem(_ item: ToDoItem) async
    func deleteToDoItem(_ id: String) async
    func updateToDoItem(_ item: ToDoItem) async
}
