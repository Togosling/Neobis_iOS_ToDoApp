//
//  MainView.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 14/4/23.
//

import UIKit
import SnapKit


class MainView: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Создайте новую задачу нажав на кнопку плюс"
        label.numberOfLines = 0
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
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    
    func setupViews() {
        
        addSubview(collectionViewController.view)
        let numberOfcells = collectionViewController.tasks.count
        collectionViewController.collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo((numberOfcells + 1) * 100 )
        }
        
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(collectionViewController.collectionView.snp.bottom).offset(16)
        }
        
        let buttonStackView = UIStackView(arrangedSubviews: [editButton,plusButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset((-1) * 100)
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
