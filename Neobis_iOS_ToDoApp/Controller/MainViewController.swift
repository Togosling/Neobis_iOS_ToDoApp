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
        
        setUpConstraints()
        
    }
    
    //MARK: SetUp UIView Constraints
    
    fileprivate func setUpConstraints() {
        
        view.addSubview(collectionViewController.view)
        collectionViewController.view.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
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
