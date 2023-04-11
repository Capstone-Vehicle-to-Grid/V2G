//
//  RegisterView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 2/16/23.
//

import SwiftUI
import iPhoneNumberField


struct RegisterView: View {
  
  @State private var username = ""
  @State private var emailRegister = ""
  @State private var passwordRegister = ""
  @State var nameText = ""
  @State var phoneText = ""
  @State var phoneEditing = false
  @State var gotologin = false
  @State private var showAlert = false
  @Binding var registerLogIn: Bool
  @StateObject var viewModel = UserViewModel()  
  
  var body: some View {
    
    //@State var phoneEditing = false
    
    NavigationView {
      
      VStack {
        
        Text("Create New Account")
          .font(.custom("overpass-semibold", size: 40))
          .foregroundColor(.blue)
          .bold()
          .padding()
        
        TextField("Name", text: $viewModel.user.username)
          .padding()
          .frame(width: 350, height: 50)
          .background(Color.black.opacity(0.05))
          .font(.custom("overpass-light", size: 16))
        //          .cornerRadius(10)
        
        TextField("Email", text: $viewModel.user.userEmail)
          .padding()
          .frame(width: 350, height: 50)
          .background(Color.black.opacity(0.05))
          .font(.custom("overpass-light", size: 16))
        //          .cornerRadius(10)
        
        SecureField("Password", text: $viewModel.user.password)
          .padding()
          .frame(width: 350, height: 50)
          .background(Color.black.opacity(0.05))
          .font(.custom("overpass-light", size: 16))
        //          .cornerRadius(10)
        
        Spacer()
          .frame(height: 30)
        
        Button(action: registerUser) {Text("Register")}
          .foregroundColor(.white)
          .frame(width: 350, height: 40)
          .font(.custom("overpass-light", size: 20))
          .background(Color.blue)
          .alert(isPresented: $showAlert) {
            Alert(
              
              title: Text("Email already in use"),
              message: Text("Please check your email or try logging in."),
              dismissButton: .default(Text("Ok"))
            )
          }
//          .cornerRadius(10)
        
        NavigationLink(destination: LoginView(isLoggedIn: $gotologin)) {
          Text("Log in here")
            .foregroundColor(.blue)
            .font(.custom("overpass-light", size: 20))
            .frame(width: 200, height: 40)
        }
        
      }
      
    }
    
  }
  func registerUser() {
      showAlert = viewModel.register()
      if showAlert == false {
          registerLogIn = viewModel.logIn()
      }
    }
}

struct RegisterView_Previews: PreviewProvider {
    @State static var registerLogIn = false
    static var previews: some View {
    RegisterView(registerLogIn: $registerLogIn)
  }
}
