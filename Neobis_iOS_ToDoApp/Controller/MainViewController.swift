//
//  MainViewController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit

class MainViewController: UIViewController{
    
    //MARK: UIElements
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Создайте новую задачу нажав на кнопку плюс"
        return label
    }()
    
    let collectionViewController = TaskCollectionViewController()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        return button
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        plusButton.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        setUpConstraints()
        
//        UserDefaults.standard.reset()
//        UserDefaults.standard.set(false, forKey: "setup")
//        UserDefaults.standard.set(0, forKey: "count")
        
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(0, forKey: "count")
        }
        
        reloadDataWithNewTask()
        
    }
    
    //MARK: Work with UserDefaults
    
    func reloadDataWithNewTask() {
        
        self.collectionViewController.tasks.removeAll()
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else {return}
        
        for i in 0 ..< count{
            
            self.collectionViewController.tasks.append(Task(taskName: UserDefaults.standard.value(forKey: "newTaskName \(i + 1)") as! String, taskDetails: UserDefaults.standard.value(forKey: "newTaskDetails \(i + 1)") as! String))
            DispatchQueue.main.async {
                self.collectionViewController.collectionView.reloadData()
            }
        }
    }
    
    //MARK: Buttons
    @objc func handlePlusButton() {
        
        let taskDetailsController = TaskDetailsController()
        taskDetailsController.modalPresentationStyle = .fullScreen
        taskDetailsController.passNewTask = {[weak self] in
            self?.reloadDataWithNewTask()
        }
        present(taskDetailsController, animated: true)
        
    }
    
    @objc func handleEditButton() {
        if editButton.currentImage == UIImage(named: "pencil") {
            editButton.setImage(UIImage(named: "cancel"), for: .normal)
            collectionViewController.grapAndRotateCells()
            collectionViewController.collectionView.reloadData()
            plusButton.isHidden = true
        } else {
            editButton.setImage(UIImage(named: "pencil"), for: .normal)
            collectionViewController.removeGrapAndRotate()
            collectionViewController.collectionView.reloadData()
            plusButton.isHidden = false
        }
        
    }
    
    //MARK: SetUp UIView Constraints
    
    fileprivate func setUpConstraints() {
        
        view.addSubview(collectionViewController.view)
        collectionViewController.view.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(500) // how make it autoresizing???
        }
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionViewController.view.snp.bottom).offset(16)
        }
        
        
        let buttonStackView = UIStackView(arrangedSubviews: [editButton,plusButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(650)
            make.leading.equalToSuperview().offset(350)
        }

    }
}
