//
//  TaskDetailsController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit
import SnapKit

class TaskDetailsController: UIViewController {
    
    let detailsView = TaskDetailsView(frame: .zero)
    var passNewTask: ((Task) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setupConstraints()
    }
    
    //MARK: AddTargets
    
    fileprivate func addTargets() {
        detailsView.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        detailsView.saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
        
    @objc func handleCancel() {
        self.dismiss(animated: true)
    }
    
    @objc func handleSave(){
        guard let taskName = detailsView.taskName.text, let taskDetails = detailsView.taskDetails.text else {return}
        if !taskName.isEmpty, !taskDetails.isEmpty {
            let newTask = Task(taskName: taskName, taskDetails: taskDetails)
            passNewTask?(newTask)
            self.dismiss(animated: true)
        } else {return}
    }
    
    fileprivate func setupConstraints() {
        
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
