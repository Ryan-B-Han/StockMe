//
//  SignInViewModel.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import AuthenticationServices

class SignInViewModel: NSObject, ObservableObject {
    @Published var validate: Bool = false
    
    func requestAppleSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    func validateUserCredential() {
        guard let current = User.current else {
            validate = false
            return
        }
        
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: current.id) { [weak self] (credentialState, error) in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    dLog("valud")
                    self?.validate = true
                default:
                    dLog("not valid")
                    self?.validate = false
                }
            }
        }
    }
}

extension SignInViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        let user = User(credential: credential)
        User.current = user
        DBManager.shared.load(user: user)
        validate = true
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dLog(error)
        validate = false
    }
}
