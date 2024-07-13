//
//  ItemCategory.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 06.07.2024.
//

import SwiftUI

enum ItemCategory: String {
    case work = "Работа"
    case study = "Учеба"
    case hobby = "Хобби"
    case other = "Не выбрано"

    func getColor() -> Color {
        switch self {
        case .work:
            C.red.swiftUIColor
        case .study:
            C.blue.swiftUIColor
        case .hobby:
            C.green.swiftUIColor
        case .other:
            C.gray.swiftUIColor
        }
    }
}
