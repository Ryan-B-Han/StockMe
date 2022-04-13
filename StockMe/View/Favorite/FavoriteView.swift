//
//  FavoriteView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/12/22.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var db = DBManager.shared
    
    var body: some View {
        VStack {
            List($db.favoriteList, id: \.id) { stock in
                StockView(stock: stock.wrappedValue)
            }
        }
        .navigationTitle("Favorite")
    }
}
