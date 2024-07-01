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
        return label
    }()
    
    
    func setCell(){
        addSubview(otherLabel)
        
        NSLayoutConstraint.activate([
            otherLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            otherLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
