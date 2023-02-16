//
//  ContentView.swift
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
  @State private var wrongEmail: Float = 0  //shows box around email if incorrect
  @State private var wrongPassword: Float = 0 //shows box around password if incorrect
  @State private var showLoginPage = false //To show next page
  
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
        
        VStack {
          Text("Welcome!")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .bold()
            .padding()
          
          Text("Sign in to continue")
            .foregroundColor(.blue)
          
          TextField("Username", text: $email)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .border(.red, width: CGFloat(wrongEmail))
          
          
          SecureField("Password", text: $password)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .border(.red, width: CGFloat(wrongPassword))
          
          Button(action: authenticateUser) {
            Text("Login")
          }
          .foregroundColor(.white)
          .frame(width: 300, height: 50)
          .background(Color.blue)
          .cornerRadius(10)
          
          Text("Don't have an account?")
            .foregroundColor(.blue)
          //need to add a link to "here" to the register page
          Text("Click here to register")
            .foregroundColor(.blue)
          
//          NavigationLink(destination: Text("You are logged in @\(email)"), isActive: $showLoginPage) {
//            EmptyView()
//          }
        }
      }.navigationBarHidden(true)
    }
  }
  
  func authenticateUser() {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if error != nil {
        // Handle error
        print("Invalid login credentials")
      } else {
        // Successful login
        print("Successful login")
      }
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
