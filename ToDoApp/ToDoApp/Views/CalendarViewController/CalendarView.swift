//
//  CalendarView.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import UIKit

class CalendarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = C.backPrimary.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
