//
//  CollectionViewController.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 5/4/23.
//

import UIKit
import SnapKit

class TaskCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    var tasks = [Task]()
    var editingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: cellId)
                
    }
    
    //MARK: Cells Gesture
    
    var gesture = UILongPressGestureRecognizer()
    
    func grapAndRotateCells() {
        
        gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        self.collectionView.addGestureRecognizer(gesture)
        editingMode = true
    }
    
    @objc func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {return}
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func removeGrapAndRotate() {
        self.collectionView.removeGestureRecognizer(gesture)
        editingMode = false
    }
    
    //MARK: Cell Configuration
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? TaskCell else {return UICollectionViewCell()}
        let task = tasks[indexPath.item]
        cell.taskName.text = task.taskName
        cell.taskDetails.text = task.taskDetails
        if !editingMode{
            cell.deleteButton.isHidden = true
        } else {
            cell.deleteButton.isHidden = false
        }
        cell.deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        cell.completeButton.addTarget(self, action: #selector(handleComplete), for: .touchUpInside)
        return cell
    }
    
    //MARK: Cell Complete Feature
    
    @objc func handleComplete(sender: UIButton) {
        if let cell = sender.superview as? TaskCell{
            if cell.completeButton.currentImage == UIImage(named: "check-box") {
                cell.completeButton.setImage(UIImage(named: "check-box-2"), for: .normal)
            } else {
                cell.completeButton.setImage(UIImage(named: "check-box"), for: .normal)
            }
        }
    }
    
    //MARK: Cell Delete Feature
    
    @objc func handleDelete(sender: UIButton) {
        if let cell = sender.superview as? TaskCell{
            if let indexPath = collectionView.indexPath(for: cell){
                tasks.remove(at: indexPath.item)
                collectionView.deleteItems(at: [indexPath])
                UserDefaultsHelper.shared.updateUserDefaults(tasks: tasks)
                guard let parentVC = parent as? MainViewController else {return}
                parentVC.updateConstraints()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 96)
    }
    
    //MARK: Movement of Cell
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = tasks.remove(at: sourceIndexPath.item)
        tasks.insert(task, at: destinationIndexPath.item)
        UserDefaultsHelper.shared.updateUserDefaults(tasks: tasks)
    }
    
    //MARK: Editing Cell Data
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if editingMode {
            let taskDetailsController = TaskDetailsController()
            taskDetailsController.detailsView.taskName.text = tasks[indexPath.item].taskName
            taskDetailsController.detailsView.taskDetails.text = tasks[indexPath.item].taskDetails
            taskDetailsController.modalPresentationStyle = .fullScreen
            taskDetailsController.passNewTask = {[weak self]
                task in
                self?.tasks.remove(at: indexPath.item)
                self?.tasks.insert(task, at: indexPath.item)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                UserDefaultsHelper.shared.updateUserDefaults(tasks: self?.tasks ?? [])
            }
            parent?.present(taskDetailsController, animated: true)
        }
    }
        
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

