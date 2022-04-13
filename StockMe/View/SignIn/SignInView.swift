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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("StockMe!")
                .font(.largeTitle)
                .accentColor(.red)
                .padding(30)
            
            Spacer()
            SignInWithAppleButton { request in
                request.requestedScopes = [.fullName, .email]
                
            } onCompletion: { result in
                switch result {
                case .failure(let error):
                    dLog(error)
                    
                case .success(let authorization):
                    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
                    let user = User(credential: credential)
                    UserManager.shared.current = user
                    DBManager.shared.load(user: user)
                    
                }
            }
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(height: 48)
            .padding(40)
        }
    }
}
