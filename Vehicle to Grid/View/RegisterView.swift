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
  @StateObject var viewModel = UserViewModel()

    
  var body: some View {
      
      //@State var phoneEditing = false
      
      NavigationView {
      
          VStack {
        
            Text("Create new account")
              .font(.largeTitle)
              .foregroundColor(.blue)
              .bold()
              .padding()

              NavigationLink(destination: LoginView(isLoggedIn: $gotologin)) {
                Text("Already registered? Log in here")
                  .foregroundColor(.blue)
                  .frame(width: 400, height: 40)
              }

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

            SecureField("Password", text: $viewModel.user.password)
              .padding()
              .frame(width: 300, height: 50)
              .background(Color.black.opacity(0.05))
              .cornerRadius(10)
              
            Button(action: registerUser) {Text("Register")}
              .foregroundColor(.white)
              .frame(width: 300, height: 50)
              .background(Color.blue)
              .cornerRadius(10)
              //.alert(isPresented: $showAlert) {
              //  Alert(
                  
              //    title: Text("Email already in use"),
              //    message: Text("This email is already associated with another account. Try logging in."),
              //    dismissButton: .default(Text("Ok"))
                  
              //  )
              //}
        }
      }
  }
    func registerUser() {
        showAlert = viewModel.register()
    }
}

struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView()
  }
}
