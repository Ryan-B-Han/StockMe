//
//  DBManager.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import Foundation
import Combine
import SwiftUI

class DBManager: ObservableObject {
    static let shared = DBManager()
    
    @Published var favorite: [String: Bool] = UserDefaults.standard.object(forKey: "favorite") as? [String: Bool] ?? [:] {
        didSet {
            UserDefaults.standard.set(favorite, forKey: "favorite")
        }
    }
    
//    func set(symbol: String, isFavorite: Bool) {
//        favorite[symbol] = isFavorite
//    }
//
//    func isFavorite(symbol: String) -> Bool {
//        return favorite[symbol] ?? false
//    }
}
