//
//  Endpoints.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation
import FileCache

enum Endpoints {
    static let getItemList: NCEndpoint<ToDoItemList> = NCEndpoint<ToDoItemList>.make(ToDoApp.Path.itemList, .get)
    static let addItem: NCEndpoint<ToDoItem> = NCEndpoint<ToDoItem>.make(ToDoApp.Path.itemList, .post)
    static let deleteItem: NCEndpoint<ToDoItemElement> = NCEndpoint<ToDoItemElement>.make(ToDoApp.Path.itemList, .delete)
    static let updateItem: NCEndpoint<ToDoItemElement> = NCEndpoint<ToDoItemElement>.make(ToDoApp.Path.itemList, .put)
}
