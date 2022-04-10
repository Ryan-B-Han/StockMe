//
//  ContentView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                Button("Fetch") {
                    Series.request(symbol: "IBM", function: .weekly) { error, series in
                        dLog(error)
                        guard let series = series else {
                            return
                        }

                        dLog(series.meta.symbol, series.meta.updatedAt, series.meta.timezone)
                        dLog(series.records.count)
                        
                        guard let first = series.records.first else { return }
                        dLog(first.date, first.high, first.low, first.close, first.volume)
                    }
                }.padding()
                
                Button("Searech") {
                    Symbol.request(keywords: "TSC") { error, symbols in
                        dLog(error)
                        guard let symbols = symbols else {
                            return
                        }
                        dLog(symbols.count)
                        guard let first = symbols.first else {
                            return
                        }
                        dLog(first.symbol, first.name, first.matchScore)
                    }
                }.padding()
                
                NavigationLink("Apple SignIn") {
                    SignInView()
                }
                .padding(10)
                
                Spacer()
            }
            .navigationTitle("Main")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

