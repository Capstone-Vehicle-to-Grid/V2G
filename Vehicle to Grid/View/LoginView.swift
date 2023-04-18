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
        
<<<<<<< Updated upstream
        Color("Background Gray")
          .ignoresSafeArea()
        
        VStack {
          
          VStack(spacing: 0) {
            
            Image("GM Logo")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 100, height: 100)
              .padding(.top, 50)
            
            Text("V2G")
              .font(.custom("overpass-semibold", size: 50))
              .foregroundColor(Color("Primary Blue"))
              .bold()
              .padding(.bottom, 30)
            
          }
=======
//        Color.blue
//          .ignoresSafeArea()
//        Circle()
//          .scale(1.7)
//          .foregroundColor(.white.opacity(0.15))
//        Circle()
//          .scale(1.35)
//          .foregroundColor(.white)i
          Image("Image 1")
              .resizable()
              .scaledToFill()
              .edgesIgnoringSafeArea(.all)
        
        VStack {
          
          Text("General Motors")
            .font(.custom("overpass-semibold", size: 50))
            .foregroundColor(Color("311 C"))
            .bold()
            .padding()
          
          // Space between title and login fields
          Spacer()
            .frame(height: 50)
>>>>>>> Stashed changes
          
          // Email text field
          TextField("Email", text: $viewModel.user.userEmail)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color("Cool Gray 1 C").opacity(0.70))
            .font(.custom("overpass-light", size: 16))
          
          // Password text field
          SecureField("Password", text: $viewModel.user.password)
            .padding()
            .frame(width: 350, height: 50)
            .background(Color("Cool Gray 1 C").opacity(0.70))
            .font(.custom("overpass-light", size: 16))
          
          Spacer()
            .frame(height: 30)
          
          // Face ID toggle switch
          Toggle("Face ID", isOn: $showSwitch)
            .frame(width:350)
            .font(.custom("overpass-light", size: 20))
            .foregroundColor(Color("Primary Black"))
          
          // Button to login
          Button(action: login) {
            Text("Log In")
          }
          .font(.custom("overpass-light", size: 20))
          .foregroundColor(Color("Accent Gray"))
          .frame(width: 350, height: 40)
<<<<<<< Updated upstream
          .background(Color("Primary Blue"))
=======
          .background(Color("311 C"))
          //          .cornerRadius(10)
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
              .foregroundColor(Color("Primary Blue"))
=======
              .foregroundColor(Color("311 C"))
>>>>>>> Stashed changes
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
