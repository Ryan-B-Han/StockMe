//
//  DetailViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

final class DetailViewModel: ObservableObject {
    var stock: Stock
    private var series: Series?
    @Published var records: [Record] = []
    @Published var state: Series.TimeSeries = .daily {
        didSet {
            fetch()
        }
    }
    @Published var showAlert: Bool = false
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    func fetch() {
        isLoading = true
        Series.request(symbol: stock.symbol, function: state) { [weak self] error, series in
            guard let self = self else { return }
            self.isLoading = false
            
            if let error = error {
                self.showAlert = true
                self.error = error
            }
            
            self.series = series
            self.records = series?.records ?? []
        }
    }
}
