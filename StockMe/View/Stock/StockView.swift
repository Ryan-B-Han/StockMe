//
//  StockView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI
import CoreData

struct StockView: View {
    let stock: Stock
    @ObservedObject var db = DBManager.shared
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    init(favorite: Favorite) {
        self.stock = Stock(favorite: favorite)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .fontWeight(.semibold)
                    .font(.title2)
                Text(stock.name)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text(stock.region + " / " + stock.timezone)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(stock.marketOpen + " - " + stock.marketClose)
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            let isFavorite = db.favoritesDictionary[stock.symbol] != nil
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(isFavorite ? Color.yellow : Color.gray)
                .onTapGesture {
                    guard let user = UserManager.shared.current else { return }
                    if isFavorite {
                        db.removeFavorite(user: user, stock: stock)
                    } else {
                        db.addFavorite(user: user, stock: stock)
                    }
                }
        }
    }
}
