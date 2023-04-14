//
//  TaskCell.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    let completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "check-box"), for: .normal)
        return button
    }()
    
    var taskName: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    var taskDetails: UILabel = {
        let label = UILabel()
        label.text = "Details"
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cancel"), for: .normal)
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        
        let labelStackView = UIStackView(arrangedSubviews: [taskName, taskDetails])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(64)
        }
        
        addSubview(completeButton)
        completeButton.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(16)
            make.width.equalTo(frame.width)
            make.height.equalTo(0.5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
