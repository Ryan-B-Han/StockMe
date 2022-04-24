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
            if viewModel.stocks.count == 0 && viewModel.isLoading == false {
                Spacer()
                
                Text("StockMe!")
                    .font(.title)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                
                Text("Search something")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                
                Spacer()

            } else if viewModel.isLoading {
                Spacer()
                
                VStack{}.progressView(.circular, isPresented: viewModel.isLoading)
                
                Spacer()
                
            } else {
                List($viewModel.stocks, id: \.id) { $stock in
                    NavigationLink {
                        DetailView(stock: stock)
                    } label: {
                        StockView(stock: stock)
                    }
                }
                .listStyle(.inset)
            }
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Search")
        .alert((viewModel.error as? NSError)?.localizedFailureReason ?? "Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
