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
            
            let isFavorite = db.favorite[stock.symbol] != nil
            Image(systemName: isFavorite ? "star.fill" : "star")
                .onTapGesture {
                    db.favorite[stock.symbol] = isFavorite ? nil : stock
                }
        }
    }
}
