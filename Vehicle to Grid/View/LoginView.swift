//
//  LoginView.swift
//  Vehicle to Grid
//
//  Created by Ben Worthington on 1/19/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
  
  // Propertiers
  @State private var showAlert = false
  @State private var showSwitch = true
  @State var goToRegister = false
  @State var showAddInfoView = false
  @StateObject var viewModel = UserViewModel()
  //  @State var needsRegister: Bool = false
  
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    
    NavigationView {
      
      ZStack() {
        
        Image("Image 1")
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
        
        VStack {
          
          Text("General Motors")
            .font(.custom("overpass-semibold", size: 50))
            .foregroundColor(Color("Accent Blue"))
            .bold()
            .padding()
          
          // Space between title and login fields
          Spacer()
            .frame(height: 50)
          
          // Email text field
          TextField("Email", text: $viewModel.user.userEmail)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color("Accent Gray").opacity(0.70))
            .font(.custom("overpass-light", size: 16))
          
          // Password text field
          SecureField("Password", text: $viewModel.user.password)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color("Accent Gray").opacity(0.70))
            .font(.custom("overpass-light", size: 16))
          
          Spacer()
            .frame(height: 30)
          
          // Face ID toggle switch
          Toggle("Face ID", isOn: $showSwitch)
            .frame(width:350)
            .font(.custom("overpass-light", size: 20))
            .foregroundColor(Color("Accent Blue"))
          
          // Button to login
          Button(action: login) {
            Text("Log In")
          }
          .font(.custom("overpass-light", size: 20))
          .foregroundColor(Color("Accent Gray"))
          .frame(width: 350, height: 40)
          .background(Color("Accent Blue"))
          //          .cornerRadius(10)
          .alert(isPresented: $showAlert) {
            Alert(
              
              title: Text("Invalid Login"),
              message: Text("Please check your email and password and try again."),
              dismissButton: .default(Text("Ok"))
              
            )
          }
          
          // Button to register
          NavigationLink(destination: RegisterView(showAddInfoView: $showAddInfoView, isLoggedIn: $isLoggedIn)) {
            Text("Register")
              .font(.custom("overpass-light", size: 20))
              .foregroundColor(Color("Accent Blue"))
              .frame(width: 200, height: 40)
          }
          
        }
        
      }.navigationBarHidden(true)
      
    }
    
  }
  
  func login() {
    
    viewModel.authenticateUser() { successfulLogin in
      
      print("Value of successfulLogin = \(successfulLogin)")
      
      if successfulLogin {
        
        isLoggedIn = true
        print("Should be logging in now...")
        
      } else {
        
        showAlert = true
        print("Invalid login.")
        
      }
      
    }
    
  }
  
}

struct LoginView_Previews: PreviewProvider {
  @State static var isLoggedIn = false
  static var previews: some View {
    LoginView(isLoggedIn: $isLoggedIn)
  }
}
