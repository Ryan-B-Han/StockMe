//
//  SearchViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    var searchText: String = "" {
        didSet {
            guard searchText.count > 0 else {
                stocks = []
                return
            }
            
            Stock.request(keywords: searchText) { error, stocks in
                if let error = error {
                    self.showAlert = true
                    self.error = error
                }
                
                guard let stocks = stocks else {
                    self.stocks = []
                    return
                }

                self.stocks = stocks
            }
        }
    }
    
    @Published var stocks: [Stock] = []
    @Published var showAlert: Bool = false
    @Published var error: Error?
}
