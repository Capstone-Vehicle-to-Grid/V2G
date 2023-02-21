//
//  RegisterView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 2/16/23.
//

import SwiftUI
//import iPhoneNumberField
//import iTextField

struct RegisterView: View {
    
    @StateObject var viewModel = UserViewModel()
    
    @State private var name = ""
    @State private var emailRegister = ""
    @State private var passwordRegister = ""
    @State var nameText = ""
    @State var phoneText = ""
    @State var phoneEditing = false
    @State var showAlert = false
    
    var body: some View {
        
        NavigationView {
            //        Text("Registeration Page")
            VStack {
                Text("Create new account")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .bold()
                    .padding()
                
                Text("Already registered? Login here.")
                    .foregroundColor(.blue)
                
                TextField("Name", text: $viewModel.user.username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                TextField("Email", text: $viewModel.user.userEmail)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //            .border(.red, width: CGFloat(wrongEmail))
                
                
                SecureField("Password", text: $viewModel.user.password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //            .border(.red, width: CGFloat(wrongPassword))
                
                
                Button(action: registerUser) {
                  Text("Register")
                }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Email already in use"),
                            message: Text("This email is already registered with another account"),
                            dismissButton: .default(Text("Ok"))
                        )}
               }
           }
                
        }
    func registerUser() {
        let newUser = viewModel.register()
        if newUser == true {
            self.showAlert = false
        }
        if newUser != true {
            self.showAlert = true
        }
        
        self.showAlert = false
    }
}
