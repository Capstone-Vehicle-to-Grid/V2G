//
//  UserViewModel.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 2/20/23.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var user: User = User(username: "", password: "", userEmail: "")
    
    private var db = Firestore.firestore()
    private var userList = Firestore.firestore().collection("users")
    
    func addUser(user: User) {
        do {
            let _ = try userList.addDocument(from: user)
        }
        catch {
            print(error)
        }
    }
    
    func register() {
        addUser(user: user)
    }
    
}
