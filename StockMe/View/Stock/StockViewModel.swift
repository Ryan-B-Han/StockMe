//
//  StockViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import SwiftUI

final class StockViewModel: ObservableObject {
    var stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
    }
}
