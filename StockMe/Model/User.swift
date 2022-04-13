//
//  User.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import AuthenticationServices
import SwiftUI

final class User: Codable {
    let id: String
    let fullname: String
    let email: String
    
    init(credential: ASAuthorizationAppleIDCredential) {
        self.id = credential.user
        self.email = credential.email ?? ""
        self.fullname = credential.fullName?.description ?? ""
    }
}
