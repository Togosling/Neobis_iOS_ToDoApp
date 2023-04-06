//
//  Helper.swift
//  Neobis_iOS_ToDoApp
//
//  Created by Тагай Абдылдаев on 6/4/23.
//


import Foundation

extension UserDefaults {

    enum Keys: String, CaseIterable {

        case unitsNotation
        case temperatureNotation
        case allowDownloadsOverCellular

    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}
