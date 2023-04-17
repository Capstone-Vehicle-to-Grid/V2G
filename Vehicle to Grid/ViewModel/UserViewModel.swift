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
  
  @Published var user: User = User(username: "", password: "", userEmail: "", vehicleMake: "", vehicleModel: "", vehicleVIN: "")
  private var db = Firestore.firestore()
  private var userList = Firestore.firestore().collection("users")
  var userAddedAlert = true
  
  func addUser(user: User) {
    self.user.userEmail = self.user.userEmail.lowercased()
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
    userList.whereField("userEmail", isEqualTo: user.userEmail.lowercased())
      .getDocuments() { (querySnapshot, err) in
        if let err = err {
          print("Error accessing database: \(err)")
          self.userAddedAlert = true
        }
        if querySnapshot!.isEmpty {
          Auth.auth().createUser(withEmail: self.user.userEmail.lowercased(), password: self.user.password) { authResult, error in
            if let err = err { print("Error creating user: \(err.localizedDescription)")
              authError = true
              self.userAddedAlert = true
            }
          }
          if authError == false {
            print("Added user")
            self.addUser(user: self.user)
            self.userAddedAlert = false
          }
        }
        else {
          print("User not added")
          self.userAddedAlert = true
        }
      }
    return userAddedAlert
    
  }
  
  
  // Will be getting rid of and replaced with authenticateUser
  func logIn() -> Bool{
    var loggedIn = false
    Auth.auth().signIn(withEmail: user.userEmail.lowercased(), password: user.password) { result, error in
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
  
  // Authenticate (login) user through firebase auth
  func authenticateUser(email: String, password: String, completition: @escaping (Bool) -> Void) {
    
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      
      if error != nil {
        
        print("Invalid login credentials")
        completition(false)
        
      } else {
        
        print("Successful login")
        completition(true)
        
      }
      
    }
    
  }
  
  func addInfo() {
    userList.whereField("userEmail", isEqualTo: user.userEmail.lowercased())
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
