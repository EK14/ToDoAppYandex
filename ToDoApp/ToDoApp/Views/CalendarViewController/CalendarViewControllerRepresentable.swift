//
//  CalendarViewControllerRepresentable.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import SwiftUI

struct CalendarViewControllerRepresentable: UIViewControllerRepresentable {
    
    var viewWillDissapear: () -> ()

    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarViewController = CalendarViewController()
        calendarViewController.viewWillDissapear = {
            viewWillDissapear()
        }
        return calendarViewController
    }

    func updateUIViewController(_ pageViewController: CalendarViewController, context: Context) {}
}
