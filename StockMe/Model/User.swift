//
//  User.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/11/22.
//

import AuthenticationServices

struct User: Codable {
    let id: String
    let fullname: String
    let email: String
    
    init(credential: ASAuthorizationAppleIDCredential) {
        self.id = credential.user
        self.email = credential.email ?? ""
        self.fullname = credential.fullName?.description ?? ""
    }
    
    static var current: User? {
        get {
            do {
                let decoder = JSONDecoder()
                guard let data = UserDefaults.standard.object(forKey: "appleIdCredential") as? Data else {
                    return nil
                }
                let user = try decoder.decode(User.self, from: data)
                return user
            } catch {
                dLog(error)
                return nil
            }
        }
        set {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: "appleIdCredential")
            } catch {
                dLog(error)
            }
        }
    }
}
