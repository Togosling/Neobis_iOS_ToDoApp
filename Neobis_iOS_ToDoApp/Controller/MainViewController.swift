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
        label.numberOfLines = 2
        label.textAlignment = .center
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        plusButton.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        addChild(collectionViewController)
                
        downloadUserDefaultsData()

        setUpConstraints()
    }
    
    //MARK: Work with UserDefaults
    
    func downloadUserDefaultsData() {
        
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            
        } else {
            if let data = UserDefaults.standard.data(forKey: "UserTasks") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([Task].self, from: data){
                    collectionViewController.tasks = decoded
                    DispatchQueue.main.async {
                        self.collectionViewController.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: Buttons
    @objc func handlePlusButton() {
        
        let taskDetailsController = TaskDetailsController()
        taskDetailsController.modalPresentationStyle = .fullScreen
        taskDetailsController.passNewTask = {[weak self]
            newTask in
            self?.collectionViewController.tasks.append(newTask)
            DispatchQueue.main.async {
                self?.collectionViewController.collectionView.reloadData()
            }
            UserDefaultsHelper.shared.updateUserDefaults(tasks: self?.collectionViewController.tasks ?? [])
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
    
    var customHeight = 100
    
    func updateConstraints() {
        
        if self.view.frame.height < 700 {
            customHeight = 30
        }
        
        let numberOfcells = collectionViewController.tasks.count
        
        collectionViewController.collectionView.snp.updateConstraints { make in
            make.height.equalTo((numberOfcells + 1) * 100 )
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        mainLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(collectionViewController.collectionView.snp.bottom).offset(16)
        }

        self.view.layoutIfNeeded()
        
    }
    
    fileprivate func setUpConstraints() {
        
        if self.view.frame.height < 700 {
            customHeight = 30
        }
        
        view.addSubview(collectionViewController.view)
        let numberOfcells = collectionViewController.tasks.count
        collectionViewController.collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo((numberOfcells + 1) * 100)
        }
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(collectionViewController.collectionView.snp.bottom).offset(16)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [editButton,plusButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset((-1) * customHeight)
            make.trailing.equalToSuperview().offset(-16)
        }

    }
}
