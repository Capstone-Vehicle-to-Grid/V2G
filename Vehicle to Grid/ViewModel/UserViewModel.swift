//
//  UserViewModel.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 2/20/23.
//

import Foundation
import Firebase
import FirebaseAuth

class UserViewModel: ObservableObject {
    
    @Published var user: User = User(username: "", password: "", userEmail: "")
    
    private var db = Firestore.firestore()
    private var userList = Firestore.firestore().collection("users")
    private var userAddedAlert = false
    
    func addUser(user: User) {
        do {
            let _ = try userList.addDocument(from: user)
        }
        catch {
            print(error)
        }
    }
    
    func register() -> Bool {
        userList.whereField("userEmail", isEqualTo: user.userEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error accessing database: \(err)")
                    self.userAddedAlert = false
                }
                if querySnapshot!.isEmpty {
                    Auth.auth().createUser(withEmail: self.user.userEmail, password: self.user.password) { authResult, error in
                        if let err = err { print("Error creating user: \(err)")
                            print("Error creating user: \(err)")
                        }
                        else {
                            print("Added user")
                            self.addUser(user: self.user)
                            self.userAddedAlert = false
                        }
                    } }
                else {
                        print("User not added")
                        self.userAddedAlert = true
                    }
                }
            return self.userAddedAlert
            }
    }
