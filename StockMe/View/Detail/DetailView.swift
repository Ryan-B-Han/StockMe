//
//  DetailView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            SymbolView(symbol: $viewModel.symbol.wrappedValue)
            
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
            
            Spacer()
        }
        .navigationTitle(viewModel.symbol.name)
        .onAppear {
            dLog()
            viewModel.fetch()
        }
    }
}
