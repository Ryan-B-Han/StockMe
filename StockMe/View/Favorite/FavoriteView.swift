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
                List($db.favorites, id: \.id) { fav in
                    let stock = Stock(favorite: fav.wrappedValue)
                    NavigationLink {
                        DetailView(stock: stock)
                    } label: {
                        StockView(stock: stock)
                    }
                }
                
            }
        }
        .navigationTitle("Favorite")
    }
}
