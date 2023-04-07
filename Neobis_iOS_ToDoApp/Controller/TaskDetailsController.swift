//
//  TaskDetailsController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit

class TaskDetailsController: UIViewController {
    
    var passNewTask: ((Task) -> ())?
    
    //MARK: UIVIew
        
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    let taskName: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Task Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = .systemFont(ofSize: 20)
        textField.textColor = .black
        textField.backgroundColor = .white
        return textField
    }()
    
    let taskDetails: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Task Details", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = .systemFont(ofSize: 20)
        textField.textColor = .black
        textField.contentVerticalAlignment = .top
        textField.backgroundColor = .white
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 246/255, green: 244/255, blue: 247/255, alpha: 100)
        
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
                
        setupConstraints()
        
    }
    
    //MARK: Buttons
    
    @objc func handleCancel() {
        self.dismiss(animated: true)
        
    }
    
    @objc func handleSave(){
        guard let taskName = taskName.text, let taskDetails = taskDetails.text else {return}
        if !taskName.isEmpty, !taskDetails.isEmpty {
            let newTask = Task(taskName: taskName, taskDetails: taskDetails)
            passNewTask?(newTask)
            self.dismiss(animated: true)
        } else {return}
    }
    
    //MARK: SetUp UIView Constraints
    
    fileprivate func setupConstraints() {
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview().offset(32)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.right.equalToSuperview().offset(-32)
        }
        
        view.addSubview(taskName)
        taskName.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(390)
        }
        
        view.addSubview(taskDetails)
        taskDetails.snp.makeConstraints { make in
            make.top.equalTo(taskName.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(600)
            make.width.equalTo(390)
        }
    }

}
