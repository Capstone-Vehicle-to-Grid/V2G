//
//  LoginView.swift
//  Vehicle to Grid
//
//  Created by Ben Worthington on 1/19/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
  
  //Propertiers
  @State private var email = ""
  @State private var password = ""
  @State private var showAlert = false
  @State private var showSwitch = true
  @State var goToRegister = false
  @StateObject var viewModel = UserViewModel()
  //  @State var needsRegister: Bool = false
  
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    
    NavigationView {
      
      ZStack() {
        
        Color.blue
          .ignoresSafeArea()
        Circle()
          .scale(1.7)
          .foregroundColor(.white.opacity(0.15))
        Circle()
          .scale(1.35)
          .foregroundColor(.white)
        
        //        Image("Image")
        //          .resizable()
        //          .scaledToFit()
        //          .frame(width: 200, height: 200) //changes size of image
        //          .position(x: 200, y:115) //moves position of image on screen
        
        VStack {
          
          Text("GM V2G")
            .font(.custom("overpass-semibold", size: 50))
            .foregroundColor(Color("285 C"))
            .bold()
            .padding()
          
          // Space between title and login fields
          Spacer()
            .frame(height: 50)
          
          // Email text field
          TextField("Email", text: $email)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color.black.opacity(0.05))
            .font(.custom("overpass-light", size: 16))
          //            .cornerRadius(10)
          
          // Password text field
          SecureField("Password", text: $password)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color.black.opacity(0.05))
            .font(.custom("overpass-light", size: 16))
          //            .cornerRadius(10)
          
          Spacer()
            .frame(height: 30)
          
          // Face ID toggle switch
          Toggle("Face ID", isOn: $showSwitch)
            .frame(width:350)
            .font(.custom("overpass-light", size: 20))
          
          // Button to login
          Button(action: login) {
            Text("Log In")
          }
          .font(.custom("overpass-light", size: 20))
          .foregroundColor(.white)
          .frame(width: 350, height: 40)
          .background(Color("285 C"))
          //          .cornerRadius(10)
          .alert(isPresented: $showAlert) {
            Alert(
              
              title: Text("Invalid Login"),
              message: Text("Please check your email and password and try again."),
              dismissButton: .default(Text("Ok"))
              
            )
          }
          
          // Button to register
          NavigationLink(destination: RegisterView(registerLogIn: $goToRegister)) {
            Text("Register")
              .font(.custom("overpass-light", size: 20))
              .foregroundColor(Color("285 C"))
              .frame(width: 200, height: 40)
          }
          
        }
        
      }.navigationBarHidden(true)
      
    }
    
  }
  
  func login() {
    
    viewModel.authenticateUser(email: email, password: password) { successfulLogin in
      
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
  
//  OLD - Function to authenticate existing user
//  func authenticateUser() {
//
//    Auth.auth().signIn(withEmail: email, password: password) { result, error in
//      if error != nil {
//
//        // Handle error
//        print("Invalid login credentials")
//        showAlert = true
//
//      } else {
//
//        // Successful login
//        print("Successful login")
//        isLoggedIn = true
//
//      }
//
//    }
//
//  }
  
}

struct LoginView_Previews: PreviewProvider {
  @State static var isLoggedIn = false
  static var previews: some View {
    LoginView(isLoggedIn: $isLoggedIn)
  }
}
