//
//  MainView.swift
//  Vehicle to Grid
//
//  Created by Ben Worthington on 2/18/23.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
  
  // Properties
  @State var isLoggedIn: Bool = false
  @State var navigated = false
  
  var body: some View {
    
    NavigationView {
      
      // If the user is currently logged in, show MainView
      if isLoggedIn {
        
        VStack{
          
          HStack{
            Text("GENERAL MOTORS")
              .background(Color .blue)
              .foregroundColor(.white)
              .font(.system(size: 45))
          }
          Spacer()
          
          //Horizontal stack to have bottons layout side by side
          HStack{
            
            NavButtons(text: "My Account", color: .blue, topPadding: 40, action: {
              //take to account page
            })
            
            NavButtons(text: "Vehicle Charge", color: .blue, topPadding: 40, action: {
              //take to vehicle charge page
            })
            
          }
          
            //Fix this mess I made Chiyou
          HStack{
            NavigationLink("", destination: MapView(), isActive: $navigated)
            NavButtons(text: "Charging Stations", color: .blue, topPadding: 40, action: {
              //take to charging stations page
                self.navigated.toggle()
            })
            
            NavButtons(text: "Grid Needs", color: .blue, topPadding: 40, action: {
            })
            
          }
          
          HStack{
            
            NavButtons(text: "Energy Demand", color: .blue, topPadding: 40, action: {
              //take to energy demand page
            })
            
            NavButtons(text: "Payment History", color: .blue, topPadding: 40, action: {
              //take to payment history page
            })
            
          }
          
          Button(action: signUserOut) {
            Text("Logout")
          }
          .foregroundColor(.white)
          .frame(width: 300, height: 50)
          .background(Color.blue)
          .cornerRadius(10)
          
        }
        
      // If the user is not logged in, revert to LoginView
      } else {
        
        // Back to login screen
        LoginView(isLoggedIn: $isLoggedIn)
        
      }
      
    }
    
  }
  
  // Function to sign current user out
  func signUserOut() {
    
    do {
      
      try Auth.auth().signOut()
      isLoggedIn = false
      print("User logged out")
      
    } catch {
      
      print("Error signing user out:", error.localizedDescription)
      
    }
    
  }
  
}

//allows us to easily create multiple buttons with the same layout
struct NavButtons: View {
  
  var text: String
  var color: Color
  var topPadding: CGFloat
  var action: () -> Void
  
  var body: some View {
    
    Button(action: action) {
      
      Text(text)
        .padding()
        .font(.title)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 120)
        .background(color)
        .cornerRadius(30)
        .shadow(radius: 40)
      
    }
    .padding(.top, topPadding)
    .padding(.horizontal)
    
  }
  
}

struct TestView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
