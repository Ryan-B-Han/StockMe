//
//  SearchView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            TextField("Symbol", text: $viewModel.searchText)
                .frame(height: 50)
                .padding()
            
            List($viewModel.symbols, id: \.id) { symbol in
                VStack {
                    Text(symbol.name.wrappedValue)
                }
            }
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
