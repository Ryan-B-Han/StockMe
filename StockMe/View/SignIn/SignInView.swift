//
//  SignInView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/8/22.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @State var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            SignInWithApple()
                .frame(height: 44)
                .padding(20)
                .onTapGesture(perform: viewModel.requestAppleSignIn)
        }
    }
}

final class SignInWithApple: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
      
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
          
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
