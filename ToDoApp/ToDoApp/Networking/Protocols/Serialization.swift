//
//  Serialization.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 17.07.2024.
//

import Foundation

protocol Serialization {
    func serialize(_ data: Self) -> Data?
}
