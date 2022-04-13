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
            
            if $viewModel.stocks.count == 0 {
                Spacer()
                Text("Empty")
                    .font(.largeTitle)
                Spacer()
                
            } else {
                List($viewModel.stocks, id: \.id) { stock in
                    NavigationLink {
                        DetailView(stock: stock.wrappedValue)
                    } label: {
                        StockView(stock: stock.wrappedValue)
                    }
                }
                
            }
            
        }
        .navigationTitle("Search")
        .alert(($viewModel.error.wrappedValue as? NSError)?.localizedFailureReason ?? "Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
