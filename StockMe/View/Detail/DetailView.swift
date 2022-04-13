//
//  DetailView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(stock: Stock) {
        viewModel = DetailViewModel(stock: stock)
    }
    
    var body: some View {
        VStack {
            StockView(stock: viewModel.stock)
                .padding()
            
            Picker("TimeSeries", selection: $viewModel.state) {
                Text("Daily").tag(Series.TimeSeries.daily)
                Text("Weekly").tag(Series.TimeSeries.weekly)
                Text("Monthly").tag(Series.TimeSeries.monthly)
            }
            .pickerStyle(.segmented)
            
            List($viewModel.records, id: \.id) { record in
                VStack(alignment: .leading) {
                    Text(record.wrappedValue.date)
                    Text(record.wrappedValue.volume)
                    Text(record.wrappedValue.low + " - " + record.wrappedValue.high)
                }
            }
        }
        .navigationTitle(viewModel.stock.name)
        .onAppear {
            dLog()
            viewModel.fetch()
        }
    }
}
