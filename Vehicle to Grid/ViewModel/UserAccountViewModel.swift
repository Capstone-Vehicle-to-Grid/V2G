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
    
    @Published var user: User = User(username: "", password: "", userEmail: "", vehicleMake: "", vehicleModel: "", vehicleVIN: "")
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
                    self.user.password = data["password"] as? String ?? ""
                    self.user.vehicleModel = data["vehicleModel"] as? String ?? ""
                    self.user.vehicleMake = data["vehicleMake"] as? String ?? ""
                    self.user.vehicleVIN = data["vehicleVIN"] as? String ?? ""
                }
            }
    }
    
    func updateInfo() {
        let loggedInUser = Auth.auth().currentUser
        if let loggedInUser = loggedInUser {
            loggedInEmail = loggedInUser.email!
        }
        self.user.userEmail = self.user.userEmail.lowercased()
        userList.whereField("userEmail", isEqualTo: loggedInEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error accessing database: \(err)")
                } else {
                    let document = querySnapshot!.documents.first
                    document!.reference.updateData([
                        "username": self.user.username,
                        "userEmail": self.user.userEmail,
                        "password": self.user.password,
                        "vehicleMake": self.user.vehicleMake,
                        "vehicleModel": self.user.vehicleModel,
                        "vehicleVIN": self.user.vehicleVIN
                    ])
                }
            }
        Auth.auth().currentUser?.updateEmail(to: user.userEmail) { error in
          print("Error: \(error)")
        }
        Auth.auth().currentUser?.updatePassword(to: user.password) { error in
          print("Error: \(error)")
        }
    }
}
