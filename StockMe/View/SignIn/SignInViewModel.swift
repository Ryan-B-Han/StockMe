//
//  SignInViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import AuthenticationServices

class SignInViewModel: NSObject {
    
    func requestAppleSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

extension SignInViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        let user = credential.user
        let email = credential.email
        let fullname = credential.fullName
        dLog(user, email, fullname)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dLog(error)
    }
}
