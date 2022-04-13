//
//  FavoriteView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/12/22.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @ObservedObject var db = DBManager.shared
    
    var body: some View {
        VStack {
            List($db.favorites, id: \.id) { fav in
                HStack {
                    VStack(alignment: .leading) {
                        Text(fav.wrappedValue.symbol ?? "")
                            .fontWeight(.semibold)
                            .font(.title2)
                        Text(fav.wrappedValue.name ?? "")
                            .font(.subheadline)
                        Text((fav.wrappedValue.region ?? "") + " / " + (fav.wrappedValue.timezone ?? ""))
                        Text((fav.wrappedValue.marketOpen ?? "") + " - " + (fav.wrappedValue.marketClose ?? ""))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .onTapGesture {
                            guard let user = User.current else { return }
                            db.removeFavorite(user: user, favorite: fav.wrappedValue)
                        }
                }
            }
        }
        .navigationTitle("Favorite")
    }
}
