//
//  RegisterView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 2/16/23.
//

import SwiftUI
import iPhoneNumberField

struct RegisterView: View {
  
  @State private var name = ""
  @State private var emailRegister = ""
  @State private var passwordRegister = ""
  @State var nameText = ""
  @State var phoneText = ""
  @State var phoneEditing = false
  
  var body: some View {
    
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
          
          SecureField("Password", text: $passwordRegister)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
          
        }
        
        //        Button(action: registerUser) {
        //          Text("Register")
        //        }
        //        .foregroundColor(.white)
        //        .frame(width: 300, height: 50)
        //        .background(Color.blue)
        //        .cornerRadius(10)
        
      }
    }
    
//    func registerUser() {
//      let newUser = viewModel.register()
//    }
    
  }
  
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
  
  //            }
  
}

}

struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView()
  }
}
