//
//  FirebaseService.swift
//  mistikaios
//
//  Created by angel on 5/10/24.
//
import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() {}

    var isLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func checkLoginStatus(completion: @escaping (Bool) -> Void) {
        if isLoggedIn {
            completion(true)
        } else {
            completion(false)
        }
    }
}
