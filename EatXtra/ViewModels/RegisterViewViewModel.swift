//
//  RegisterViewViewModel.swift
//  EatXtra
//
//  Created by Subham Patel on 21/01/25.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseStorage
class RegisterViewViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func register(completion: @escaping (Bool) -> Void) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    self?.addNameToUser(name: self?.name ?? "", completion: completion)
                    completion(true)
                }
            }
        }
    }
    
    private func addNameToUser(name: String, completion: @escaping (Bool) -> Void) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Failed to update name: \(error.localizedDescription)")
                completion(false)
            }else{
                completion(true)
            }
        }
    }
}
