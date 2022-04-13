//
//  StockViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import SwiftUI

class StockViewModel: ObservableObject {
    var stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
    }
}
