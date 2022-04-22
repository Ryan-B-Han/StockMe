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

            if $viewModel.records.count == 0 {
                Spacer()
                Text("Empty")
                    .font(.largeTitle)
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
                        .onMove(perform: moveItem)
                        .onDelete(perform: deleteItem)
                        
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
        .toolbar(content: {
            EditButton()
        })
        .onAppear {
            viewModel.fetch()
        }
        .alert(($viewModel.error.wrappedValue as? NSError)?.localizedFailureReason ?? "Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func moveItem(at: IndexSet, to: Int) {
        guard let idx = at.first else { return }
                
        let item = viewModel.records.remove(at: idx)
        viewModel.records.insert(item, at: to)
    }
    
    private func deleteItem(at: IndexSet) {
        viewModel.records.remove(atOffsets: at)
    }
}
