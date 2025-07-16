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
        if FileManager.default.fileExists(atPath: filename.path),
           let data = try? Data(contentsOf: filename),
           let image = UIImage(data: data) {
            self.profileImage = image
        } else {
            self.profileImage = nil  // clear the image if not found
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var profileImagePath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("profile.jpg")
    }

    func removeProfileImage() {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: profileImagePath.path) {
            do {
                try fileManager.removeItem(at: profileImagePath)
                profileImage = nil
            } catch {
                print("Error removing image: \(error.localizedDescription)")
            }
        }
    }
}
