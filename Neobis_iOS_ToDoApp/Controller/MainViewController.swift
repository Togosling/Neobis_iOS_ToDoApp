//
//  MainViewController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit

class MainViewController: UIViewController{
    
    let mainView = MainView(frame: .zero)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConstraints()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpConstraints()
        addTargets()
        addChild(mainView.collectionViewController)
        downloadUserDefaultsData()
    }
    
    //MARK: Work with UserDefaults
    
    func downloadUserDefaultsData() {
        if !UserDefaults.standard.bool(forKey: "setup") {
            UserDefaults.standard.set(true, forKey: "setup")
            
        } else {
            if let data = UserDefaults.standard.data(forKey: "UserTasks") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([Task].self, from: data){
                    mainView.collectionViewController.tasks = decoded
                    DispatchQueue.main.async {
                        self.mainView.collectionViewController.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: Buttons
    fileprivate func addTargets() {
        mainView.plusButton.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        mainView.editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
    }
    
    @objc func handlePlusButton() {
        let taskDetailsController = TaskDetailsController()
        taskDetailsController.modalPresentationStyle = .fullScreen
        taskDetailsController.passNewTask = {[weak self]
            newTask in
            self?.mainView.collectionViewController.tasks.append(newTask)
            DispatchQueue.main.async {
                self?.mainView.collectionViewController.collectionView.reloadData()
            }
            UserDefaultsHelper.shared.updateUserDefaults(tasks: self?.mainView.collectionViewController.tasks ?? [])
        }
        present(taskDetailsController, animated: true)
    }
    
    @objc func handleEditButton() {
        if mainView.editButton.currentImage == UIImage(named: "pencil") {
            mainView.editButton.setImage(UIImage(named: "cancel"), for: .normal)
            mainView.collectionViewController.grapAndRotateCells()
            mainView.collectionViewController.collectionView.reloadData()
            mainView.plusButton.isHidden = true
        } else {
            mainView.editButton.setImage(UIImage(named: "pencil"), for: .normal)
            mainView.collectionViewController.removeGrapAndRotate()
            mainView.collectionViewController.collectionView.reloadData()
            mainView.plusButton.isHidden = false
        }
    }
    
     func updateConstraints() {
        
         let numberOfcells = mainView.collectionViewController.tasks.count
        
         mainView.collectionViewController.collectionView.snp.updateConstraints { make in
            make.height.equalTo((numberOfcells + 1) * 100 )
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
         mainView.mainLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
             make.top.equalTo(mainView.collectionViewController.collectionView.snp.bottom).offset(16)
        }
        
         self.mainView.layoutIfNeeded()
    }
    
    fileprivate func setUpConstraints() {
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
