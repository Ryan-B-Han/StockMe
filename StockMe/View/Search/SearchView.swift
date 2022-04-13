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
                .padding()
                .textFieldStyle(.roundedBorder)
            
            List($viewModel.stocks, id: \.id) { stock in
                NavigationLink {
                    DetailView(stock: stock.wrappedValue)
                } label: {
                    StockView(stock: stock.wrappedValue)
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
