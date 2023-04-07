//
//  UserDefaultsHelper.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 7/4/23.
//

import Foundation


class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    func updateUserDefaults(tasks: [Task]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks){
            UserDefaults.standard.set(encoded, forKey: "UserTasks")
        }
    }
}
