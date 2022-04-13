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
    
    @Published var favorite: [String: Stock] = DBManager.load() {
        didSet {
            DBManager.store(favorite: favorite)
            favoriteList = favorite.values.compactMap({ $0 })
        }
    }
    
    @Published var favoriteList: [Stock] = []
    
    func refresh() {
        favorite = DBManager.load()
    }
    
    private static func load() -> [String: Stock] {
        guard let data = UserDefaults.standard.object(forKey: "favorite") as? Data else { return [:] }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([String:Stock].self, from: data)
            return result
        } catch {
            dLog(error)
            return [:]
        }
    }
    
    private static func store(favorite: [String: Stock]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(favorite)
            UserDefaults.standard.set(data, forKey: "favorite")
        } catch {
            dLog(error)
        }
    }
}
