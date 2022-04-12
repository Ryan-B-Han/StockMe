//
//  StockView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

struct StockView: View {
    @ObservedObject var viewModel: StockViewModel
    
    init(stock: Stock) {
        self.viewModel = StockViewModel(stock: stock)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.stock.symbol)
                    .fontWeight(.semibold)
                    .font(.title2)
                Text(viewModel.stock.name)
                    .font(.subheadline)
                Text(viewModel.stock.region + " / " + viewModel.stock.timezone)
                Text(viewModel.stock.marketOpen + " - " + viewModel.stock.marketClose)
            }
            
            Spacer()
            
            Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                .onTapGesture {
                    viewModel.isFavorite = !viewModel.isFavorite
                }
        }
    }
}
