//
//  DetailViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    var symbol: Symbol
    private var series: Series?
    @Published var records: [Record] = []
    @Published var state: Series.TimeSeries = .daily {
        didSet {
            fetch()
        }
    }
    @Published var isLoading: Bool = false
    
    init(symbol: Symbol) {
        self.symbol = symbol
    }
    
    func fetch() {
        dLog()
        isLoading = true
        Series.request(symbol: symbol.symbol, function: state) { [weak self] error, series in
            guard let self = self else { return }
            dLog(error, series)
            self.isLoading = false
            self.series = series
            self.records = series?.records ?? []
        }
    }
}
