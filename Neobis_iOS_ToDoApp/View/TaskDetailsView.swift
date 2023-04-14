//
//  TaskDetailsView.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 14/4/23.
//

import UIKit
import SnapKit

class TaskDetailsView: UIView {
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.tintColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .blue
        button.titleLabel?.font = .systemFont(ofSize: 20)
        return button
    }()
    
    let taskName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Task Name"
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        return textField
    }()
    
    let taskDetails: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Task Details"
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .white
        textField.contentVerticalAlignment = .top
        textField.textAlignment = .left
        return textField
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor(red: 246/255, green: 244/255, blue: 247/255, alpha: 100)

        setupViews()
    }
    
    fileprivate func setupViews() {
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(flexibleHeight(to: 60))
            make.leading.equalToSuperview().offset(flexibleWidth(to: 20))
        }
        addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(flexibleHeight(to: 60))
            make.trailing.equalToSuperview().offset(flexibleWidth(to: -20))
        }
        addSubview(taskName)
        taskName.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(flexibleHeight(to: 30))
            make.leading.equalToSuperview().offset(flexibleWidth(to: 20))
            make.trailing.equalToSuperview().offset(flexibleWidth(to: -20))
            make.height.equalTo(flexibleHeight(to: 50))
        }
        addSubview(taskDetails)
        taskDetails.snp.makeConstraints { make in
            make.top.equalTo(taskName.snp.bottom).offset(flexibleHeight(to: 30))
            make.leading.equalToSuperview().offset(flexibleWidth(to: 20))
            make.trailing.equalToSuperview().offset(flexibleWidth(to: -20))
            make.height.equalTo(flexibleHeight(to: 700))
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
