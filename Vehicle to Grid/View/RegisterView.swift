//
//  RegisterView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 2/16/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var name = ""
    @State private var emailRegister = ""
    @State private var passwordRegister = ""
    @State private var phoneNumber = ""
    
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
                
                TextField("name", text: $name)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                TextField("Email", text: $emailRegister)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //            .border(.red, width: CGFloat(wrongEmail))
                
                
                SecureField("Password", text: $passwordRegister)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //            .border(.red, width: CGFloat(wrongPassword))
                
                TextField("phoneNumber", text: $phoneNumber)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                // Button to Sign Up
//                Button(action: authenticateUser) {
//                  Text("Sign Up")
//                }
//                .foregroundColor(.white)
//                .frame(width: 300, height: 50)
//                .background(Color.blue)
//                .cornerRadius(10)
//                .alert(isPresented: $showAlert) {
//                  Alert(
//
//
//
//                  )
//                }
                
            }
        }
    }
}


//struct RegisterView_Previews: PreviewProvider {
//  
//  @State static var isRegistered = false
//  
//  static var previews: some View {
//    RegisterView(isRegistered: $isRegistered)
//  }
//}
