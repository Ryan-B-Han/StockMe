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

            if $viewModel.records.count == 0 && viewModel.isLoading == false {
                EmptyView()

            } else if viewModel.isLoading {
                Spacer()
                
                VStack{}.progressView(.circular, isPresented: viewModel.isLoading)
                
                Spacer()
                
            } else {
                List {
                    Section {
                        ForEach(Array(zip($viewModel.records.indices, $viewModel.records)), id: \.0) { index, $record in
                            HStack {
                                Text(record.date)
                                Spacer()
                                Text(record.volume)
                                Spacer()
                                Text(record.high)
                                Spacer()
                                Text(record.low)
                            }
                            .listRowBackground(index%2==0 ? Color.gray.opacity(0.1) : Color.white)
                        }
                        
                    } header: {
                        HStack {
                            Text("Date")
                            Spacer()
                            Text("Volume")
                            Spacer()
                            Text("High")
                            Spacer()
                            Text("Low")
                        }
                    } footer: {
                        Text("End of the list")
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(viewModel.stock.name)
        .onAppear {
            viewModel.fetch()
        }
        .alert(($viewModel.error.wrappedValue as? NSError)?.localizedFailureReason ?? "Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
