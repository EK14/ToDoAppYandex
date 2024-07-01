//
//  CalendarDayCollectionViewCell.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import UIKit

class CalendarDayCollectionViewCell: UICollectionViewCell {
    
    lazy var day: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = C.calendarBorder.color
        return label
    }()
    
    lazy var month: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = C.calendarBorder.color
        return label
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    func setCell(day: String, month: String){
        layer.cornerRadius = 10
        
        self.day.text = day
        self.month.text = month
        
        verticalStack.addArrangedSubview(self.day)
        verticalStack.addArrangedSubview(self.month)
        addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
//    override var isSelected: Bool {
//        didSet {
//            day.textColor = isSelected ? .white : .black
//            month.textColor = isSelected ?
//        }
//    }
}
