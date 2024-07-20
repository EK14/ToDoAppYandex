//
//  Deserialization.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation

protocol Deserialization {
    static func deserialize(from data: Data) throws -> Self?
}
