//
//  OtherDateCollectionViewCell.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import UIKit

class OtherDateCollectionViewCell: UICollectionViewCell {
    lazy var otherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Другое"
        label.textColor = C.calendarBorder.color
        return label
    }()
    
    
    func setCell(){
        layer.cornerRadius = 10
        
        addSubview(otherLabel)
        
        NSLayoutConstraint.activate([
            otherLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            otherLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = C.calendarBackground.color
                layer.borderWidth = 2.0
                layer.borderColor = C.calendarBorder.color.cgColor
            } else {
                backgroundColor = C.backPrimary.color
                layer.borderColor = C.calendarBorder.color.cgColor
                layer.borderWidth = 0.0
            }
        }
    }
}
