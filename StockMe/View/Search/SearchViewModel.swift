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
                symbols = []
                return
            }
            
            Symbol.request(keywords: searchText) { error, symbols in
                dLog(error)
                guard let symbols = symbols else {
                    self.symbols = []
                    return
                }

                self.symbols = symbols
            }
        }
    }
    
    @Published var symbols: [Symbol] = []
}
