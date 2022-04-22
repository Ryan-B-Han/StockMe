//
//  EmptyView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/22/22.
//

import SwiftUI

struct EmptyView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            Image(systemName: "nosign")
                .resizable()
                .foregroundColor(Color.gray)
                .frame(width: 50, height: 50)
            
            Spacer()
        }
    }
}
