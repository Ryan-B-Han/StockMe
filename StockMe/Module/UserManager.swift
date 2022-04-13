//
//  UserManager.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/13/22.
//

import Foundation
import AuthenticationServices

final class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var current: User? {
        didSet {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(current)
                UserDefaults.standard.set(data, forKey: "appleIdCredential")
            } catch {
                dLog(error)
            }
        }
    }
    
    func load(completion: @escaping () -> Void) {
        do {
            guard let data = UserDefaults.standard.object(forKey: "appleIdCredential") as? Data else {
                current = nil
                completion()
                return
            }
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            validateUserCredential(user: user) { [weak self] success in
                if success {
                    self?.current = user
                } else {
                    self?.current = nil
                }
                completion()
            }
            
        } catch {
            current = nil
            completion()
            
        }
    }
    
    private func validateUserCredential(user: User, completion: @escaping (_ success: Bool) -> Void) {
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: user.id) { (credentialState, error) in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    completion(true)
                default:
                    completion(false)
                }
            }
        }
    }

}
