//
//  View+.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/22/22.
//

import SwiftUI

extension View {

    /// Sets the style for lists within this view.
    public func progressView<S>(_ style: S, isPresented: Binding<Bool>) -> some View where S : ProgressViewStyle {
        return ZStack {
            self
            
            if isPresented.wrappedValue {
                ProgressView().progressViewStyle(style)
            }
        }
    }

}
