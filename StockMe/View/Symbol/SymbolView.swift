//
//  SymbolView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import SwiftUI

struct SymbolView: View {
    @State var symbol: Symbol
    
    var body: some View {
        HStack {
            VStack {
                Text(symbol.name)
                Text(symbol.type)
                Text(symbol.marketOpen + " - " + symbol.marketClose)
                Text(symbol.region + " / " + symbol.timezone)
                Text(symbol.currency)
                Text(symbol.matchScore)
            }
            
            Text(symbol.symbol)
        }
    }
}
