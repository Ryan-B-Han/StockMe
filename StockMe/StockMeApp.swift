//
//  StockMeApp.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/8/22.
//

import SwiftUI

@main
struct StockMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    DBManager.shared.refresh()
                }
        }
    }
}
