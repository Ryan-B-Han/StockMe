//
//  StockViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import SwiftUI

class StockViewModel: ObservableObject {
    var stock: Stock
    @Published var isFavorite: Bool = false {
        didSet {
            DBManager.shared.set(symbol: stock.symbol, isFavorite: isFavorite)
        }
    }
    
    init(stock: Stock) {
        self.stock = stock
        isFavorite = DBManager.shared.isFavorite(symbol: stock.symbol)
    }
}
