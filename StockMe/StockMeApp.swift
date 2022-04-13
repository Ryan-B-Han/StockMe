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
                .onAppear {
                    // Load stored User and validate
                    UserManager.shared.load {
                        guard let user = UserManager.shared.current else { return }
                        // Load favorite list of the user
                        DBManager.shared.load(user: user)
                    }
                }
        }
    }
}
