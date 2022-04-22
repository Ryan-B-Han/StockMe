//
//  ContentView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var userManager = UserManager.shared
    
    
    var body: some View {
        if $userManager.current.wrappedValue == nil {
            SignInView()

        } else {
            NavigationView {
                SearchView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            NavigationLink {
                                FavoriteView()
                            } label: {
                                Text("Favorite")
                            }
                        })
                    }
            }
        }
    }
}
