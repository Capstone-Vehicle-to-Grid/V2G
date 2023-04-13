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
  @State var showAlert = false
  @State var showAddInfoView = false
  @Binding var registerLogIn: Bool
  @StateObject var viewModel = UserViewModel()  
  
  var body: some View {
    
    //@State var phoneEditing = false
    
    NavigationView {
      
      VStack {
        
        Text("Create New Account")
          .font(.custom("overpass-semibold", size: 40))
          .foregroundColor(Color("285 C"))
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
        
          NavigationLink(destination: AddInfoView(), isActive: $showAddInfoView){
              Button(action: {
                  self.showAddInfoView = false
                  self.showAddInfoView = registerUser()
              }) {Text("Register")}
                  .foregroundColor(.white)
                  .frame(width: 350, height: 40)
                  .font(.custom("overpass-light", size: 20))
                  .background(Color("285 C"))
                  .alert(isPresented: $showAlert, content: { pickAlert()})
          }
        
        NavigationLink(destination: LoginView(isLoggedIn: $gotologin)) {
          Text("Log in here")
            .foregroundColor(Color("285 C"))
            .font(.custom("overpass-light", size: 20))
            .frame(width: 200, height: 40)
        }
        
      }
      
    }
    
  }
  func registerUser() -> Bool {
      showAlert = false
      showAlert = viewModel.register()
      if showAlert == false {
          return true
      }
      else {
          return false }
    }
    
    func pickAlert() -> Alert {
        return Alert(
            title: Text("Email already in use"),
            message: Text("Please check your email or try logging in."),
            dismissButton: .default(Text("Ok"))
          )
    }
}


struct RegisterView_Previews: PreviewProvider {
    @State static var registerLogIn = false
    static var previews: some View {
    RegisterView(registerLogIn: $registerLogIn)
  }
}
