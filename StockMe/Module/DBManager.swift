//
//  DBManager.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import SwiftUI
import CoreData

final class DBManager: ObservableObject {
    static let shared = DBManager()
    
    @Published var favorites: [Favorite] = [] {
        didSet {
            favoritesDictionary = Dictionary(uniqueKeysWithValues: favorites.map{ ($0.symbol!, $0) })
        }
    }
    private(set) var favoritesDictionary: [String: Favorite] = [:]
    
    func load(user: User) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let predicate = NSPredicate(format: "user == %@", user.id)
        fetchRequest.predicate = predicate
        do {
            favorites = try PersistenceController.shared.container.viewContext.fetch(fetchRequest) as! [Favorite]
        } catch {
            dLog(error)
        }
    }
    
    func addFavorite(user: User, stock: Stock) {
        let favorite = Favorite.create(context: PersistenceController.shared.container.viewContext, stock: stock, user: user)
        favorites.append(favorite)
        save()
    }
    
    func removeFavorite(user: User, stock: Stock) {
        guard let fav = favorites.first(where: { $0.symbol == stock.symbol}) else { return }
        removeFavorite(user: user, favorite: fav)
    }
    
    func removeFavorite(user: User, favorite: Favorite) {
        favorites.removeAll(where: { $0.symbol == favorite.symbol })
        PersistenceController.shared.container.viewContext.delete(favorite)
        save()
    }
    
    private func save() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            dLog(error)
        }
    }
}

extension Favorite {
    static func create(context: NSManagedObjectContext, stock: Stock, user: User) -> Favorite {
        let favorite = Favorite(context: context)
        favorite.id = stock.id
        favorite.name = stock.name
        favorite.user = user.id
        favorite.symbol = stock.symbol
        favorite.currency = stock.currency
        favorite.marketOpen = stock.marketOpen
        favorite.marketClose = stock.marketClose
        favorite.type = stock.type
        favorite.timezone = stock.timezone
        return favorite
    }
}
