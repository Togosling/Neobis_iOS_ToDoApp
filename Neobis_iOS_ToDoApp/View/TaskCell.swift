//
//  TaskCell.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .purple
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
