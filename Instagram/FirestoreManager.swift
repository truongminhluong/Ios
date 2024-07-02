//
//  FirestoreManager.swift
//  Instagram
//
//  Created by Trương Minh Lượng Jr on 12/3/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirestoreManager {
    static let shared = FirestoreManager()
    
    private init() {}
    
    func addUserInfo(userInfo: User) {
        let db = Firestore.firestore()
        try db.collection("users").document(Auth.auth().currentUser?.uid ?? "").setData(userInfo.toDictionary()) { error in
            if let error = error {
                print("Error adding user data: \(error.localizedDescription)")
            } else {
                print("User data added successfully")
            }
        }
    }
    

    
    
}

