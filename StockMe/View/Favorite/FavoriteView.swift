//
//  FavoriteView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/12/22.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @ObservedObject var db = DBManager.shared
    
    var body: some View {
        VStack {
            if $db.favorites.count == 0 {
                EmptyView()
                
            } else {
                List {
                    ForEach($db.favorites) { fav in
                        let stock = Stock(favorite: fav.wrappedValue)
                        NavigationLink {
                            DetailView(stock: stock)
                        } label: {
                            StockView(stock: stock)
                        }
                    }
                    .onMove(perform: moveItem)
                    .onDelete(perform: deleteItem)
                }
            }
        }
        .navigationTitle("Favorite")
        .toolbar {
            EditButton()
        }
    }
    
    private func moveItem(at: IndexSet, to: Int) {
        guard let idx = at.first else { return }
                
        let item = db.favorites.remove(at: idx)
        db.favorites.insert(item, at: to)
    }
    
    private func deleteItem(at: IndexSet) {
        db.favorites.remove(atOffsets: at)
    }
}
