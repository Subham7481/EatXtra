//
//  ProfileViewViewModel.swift
//  EatXtra
//
//  Created by Subham Patel on 21/01/25.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
class ProfileViewViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoggedIn: Bool = false
    @Published var profileImage: UIImage?

    init() {
        fetchUserData()
        loadImageFromDisk()
    }
        
    func fetchUserData() {
        if let currentUser = Auth.auth().currentUser {
            self.user = User(uid: currentUser.uid,
                             displayName: currentUser.displayName,
                             email: currentUser.email)
        }
        
    }


    func logout(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true) // Notify success
        } catch let error {
            print("Failed to log out: \(error.localizedDescription)")
            completion(false) // Notify failure
        }
    }
    
    func checkAuthentication() {
           // Update isLoggedIn based on current auth state
           isLoggedIn = Auth.auth().currentUser != nil
    }
    
    func saveImageToDisk(_ image: UIImage) {
        self.profileImage = image
        if let data = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
            try? data.write(to: filename)
        }
    }

    func loadImageFromDisk() {
        let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
        if let data = try? Data(contentsOf: filename) {
            self.profileImage = UIImage(data: data)
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
