//
//  SignInView.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/8/22.
//

/***
 This featur must be tested on a real device. The sign-in doesn't work on a simulator
 https://developer.apple.com/forums/thread/651533
 ***/


import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            if($viewModel.validate.wrappedValue) {
                Text(User.current!.id)
                Text(User.current!.fullname)
                Text(User.current!.email)
            }
            
            Spacer()
            
            if(!$viewModel.validate.wrappedValue) {
                SignInWithApple()
                    .frame(height: 44)
                    .padding(20)
                    .onTapGesture(perform: viewModel.requestAppleSignIn)
            }
        }
        .onAppear {
            dLog()
            viewModel.validateUserCredential()
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
