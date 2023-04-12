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
    
    @Published var user: User = User(username: "", password: "", userEmail: "test@email.com", vehicleMake: "", vehicleModel: "", vehicleVIN: "")
    private var db = Firestore.firestore()
    private var userList = Firestore.firestore().collection("users")
    private var userAddedAlert = false
    
    func addUser(user: User) {
        do {
            let _ = try userList.addDocument(data: [
                "username": self.user.username,
                "userEmail": self.user.userEmail.lowercased(),
                "password": self.user.password
            ])
        }
        catch {
            print(error)
        }
    }
    
    func register() -> Bool{
        var authError = false
        userList.whereField("userEmail", isEqualTo: user.userEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error accessing database: \(err)")
                    self.userAddedAlert = false
                }
                if querySnapshot!.isEmpty {
                    Auth.auth().createUser(withEmail: self.user.userEmail, password: self.user.password) { authResult, error in
                        if let err = err { print("Error creating user: \(err.localizedDescription)")
                            authError = true
                            self.userAddedAlert = false
                        }
                    }
                    if authError == false {
                        print("Added user")
                        self.addUser(user: self.user)
                        self.userAddedAlert = true
                        }
                    }
                else {
                        print("User not added")
                        self.userAddedAlert = false
                    }
                }
        return userAddedAlert
        
            }
    
    func logIn() -> Bool{
        var loggedIn = false
        Auth.auth().signIn(withEmail: user.userEmail, password: user.password) { result, error in
              if error != nil {
                  print("Could not log in")
                  loggedIn = false
              } else {
                print("Successful login")
                loggedIn = true
              }
            }
        return loggedIn
    }
    
    func addInfo() {
        userList.whereField("userEmail", isEqualTo: user.userEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error accessing database: \(err)")
                } else {
                    let document = querySnapshot!.documents.first
                    document!.reference.updateData([
                        "vehicleMake": self.user.vehicleMake,
                        "vehicleModel": self.user.vehicleModel,
                        "vehicleVIN": self.user.vehicleVIN
                    ])
                }
            }
    }
}
