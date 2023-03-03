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
  //  @State var needsRegister: Bool = false
  
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    
    NavigationView {
      
      ZStack {
        
        Color.blue
          .ignoresSafeArea()
        Circle()
          .scale(1.7)
          .foregroundColor(.white.opacity(0.15))
        Circle()
          .scale(1.35)
          .foregroundColor(.white)
        
        Image("Image")
          .resizable()
        //.scaledToFit()
          .frame(width: 200, height: 200) //changes size of image
          .position(x: 200, y:115) //moves position of image on screen
        
        VStack {
          
          Text("Welcome!")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .bold()
            .padding()
          
          Text("Sign in to continue")
            .foregroundColor(.blue)
          
          TextField("Email", text: $email)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
          
          SecureField("Password", text: $password)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
          
          // Button to login
          Button(action: authenticateUser) {
            Text("Login")
          }
          .foregroundColor(.white)
          .frame(width: 300, height: 50)
          .background(Color.blue)
          .cornerRadius(10)
          .alert(isPresented: $showAlert) {
            Alert(
              
              title: Text("Invalid Login"),
              message: Text("Please check your email and password and try again."),
              dismissButton: .default(Text("Ok"))
              
            )
          }
          
          // Button to go to the register view
          NavigationLink(destination: RegisterView()) {
            Text("Click here to register")
              .foregroundColor(.blue)
              .underline()
          }
          
        }
        
      }.navigationBarHidden(true)
      
    }
    
  }
  
  // Function to authenticate existing user
  func authenticateUser() {
    
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if error != nil {
        
        // Handle error
        print("Invalid login credentials")
        showAlert = true
        
      } else {
        
        // Successful login
        print("Successful login")
        isLoggedIn = true
        
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
