//
//  UserAccountViewModel.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserAccountViewModel: ObservableObject {
    
    @Published var user: User = User(username: "Test", password: "", userEmail: "Test2")
    private var userList = Firestore.firestore().collection("users")
    private var loggedInEmail: String = ""
    
    
    func getUserData() {
        let loggedInUser = Auth.auth().currentUser
        if let loggedInUser = loggedInUser {
            loggedInEmail = loggedInUser.email!
        }
        userList.whereField("userEmail", isEqualTo: loggedInEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error accessing database: \(err)")
                }
                if querySnapshot!.isEmpty{
                    print("ERROR: No user found in database")
                }
                
                for document in querySnapshot!.documents{
                    let data = document.data()
                    self.user.username = data["username"] as? String ?? ""
                    self.user.userEmail = data["userEmail"] as? String ?? ""
                }
            }
    }
    
}
