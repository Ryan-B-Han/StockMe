//
//  StockView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

struct StockView: View {
    let stock: Stock
    @ObservedObject var db = DBManager.shared
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .fontWeight(.semibold)
                    .font(.title2)
                Text(stock.name)
                    .font(.subheadline)
                Text(stock.region + " / " + stock.timezone)
                Text(stock.marketOpen + " - " + stock.marketClose)
            }
            
            Spacer()
            
            Image(systemName: db.favorite[stock.symbol] == true ? "star.fill" : "star")
                .onTapGesture {
                    let isFavorite = db.favorite[stock.symbol] ?? false
                    db.favorite[stock.symbol] = !isFavorite
                }
        }
    }
}
