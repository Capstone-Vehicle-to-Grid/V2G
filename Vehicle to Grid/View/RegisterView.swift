//
//  RegisterView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 2/16/23.
//

import SwiftUI
import iPhoneNumberField


struct RegisterView: View {
  
  //  @State var showAddInfoView: Bool = false
  @State var nameText = ""
  @State var phoneText = ""
  @State var phoneEditing = false
  //  @State var gotologin = false
  @State var showAlert = false
  //  @State var showAddInfoView = false
  //  @Binding var registerLogIn: Bool
  @Binding var showAddInfoView: Bool
  @Binding var isLoggedIn: Bool
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
        
        Button(action: {
          register()
        }) {Text("Register")}
          .foregroundColor(.white)
          .frame(width: 350, height: 40)
          .font(.custom("overpass-light", size: 20))
          .background(Color("285 C"))
          .alert(isPresented: $showAlert) {
            Alert(
              
              title: Text("Email already in use"),
              message: Text("Please check your email or try logging in."),
              dismissButton: .cancel(Text("Ok"))
              
            )
          }
        
        //        NavigationLink(destination: AddInfoView(), isActive: $showAddInfoView){
        //          Button(action: {
        ////            self.showAddInfoView = false
        ////            self.showAddInfoView = registerUser()
        ////            test()
        //            register()
        //          }) {Text("Register")}
        //            .foregroundColor(.white)
        //            .frame(width: 350, height: 40)
        //            .font(.custom("overpass-light", size: 20))
        //            .background(Color("285 C"))
        //            .alert(isPresented: $showAlert) {
        //              Alert(
        //
        //                title: Text("Email already in use"),
        //                message: Text("Please check your email or try logging in."),
        //                dismissButton: .cancel(Text("Ok"))
        //
        //              )
        //            }
        //        }
        
        //        NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
        //          Text("Log in here")
        //            .foregroundColor(Color("285 C"))
        //            .font(.custom("overpass-light", size: 20))
        //            .frame(width: 200, height: 40)
        //        }
        
      }
      
    }
    
  }
  
  func register() {
    
    viewModel.register() { successfulRegister in
      
      print("Value of successfulRegister = \(successfulRegister)")
      
      if !successfulRegister {
        
        showAddInfoView = true
        print("User successfully registered")
        
      } else {
        
        showAlert = true
        print("User already exists")
        
      }
      
    }
    
//    let registerSuccess = viewModel.register()
//
//    print("Value of registerSuccess = \(registerSuccess)")
//
//    if !registerSuccess {
//
//      showAddInfoView = true
//
//    } else {
//
//      showAlert = true
//
//    }
    
  }
  
//  func registerUser() -> Bool {
//    showAlert = false
//    showAlert = viewModel.register()
//    if showAlert == false {
//      return true
//    }
//    else {
//      return false }
//  }
  
  //  func pickAlert() -> Alert {
  //    return Alert(
  //      title: Text("Email already in use"),
  //      message: Text("Please check your email or try logging in."),
  //      dismissButton: .default(Text("Ok"))
  //    )
  //  }
  
}


struct RegisterView_Previews: PreviewProvider {
  //  @State static var registerLogIn = false
  @State static var showAddInfoView = false
  @State static var isLoggedIn = false
  static var previews: some View {
    RegisterView(showAddInfoView: $showAddInfoView, isLoggedIn: $isLoggedIn)
  }
}
