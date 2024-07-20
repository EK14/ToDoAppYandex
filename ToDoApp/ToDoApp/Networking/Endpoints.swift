//
//  Endpoints.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation
import FileCache

enum Endpoints {
    static let getItemList: NCEndpoint<GetItemListResponse> = NCEndpoint<GetItemListResponse>.make(ToDoApp.Path.itemList, .get)
    static let addItem: NCEndpoint<ToDoItem> = NCEndpoint<ToDoItem>.make(ToDoApp.Path.itemList, .post)
}
