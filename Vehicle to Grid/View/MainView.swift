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
  @State var navigatedMyAccount = false
  @State var navigatedVehicleCharge = false
  @Environment(\.openURL) var openURL
//  @State var goToAccount = false
  
  var body: some View {
      
    NavigationView {
      
      // If the user is currently logged in, show MainView
      if isLoggedIn {
        VStack{
            
//            GeometryReader { geo in
//                Image("Image")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: geo.size.width * 7)
//                    .frame(width: geo.size.width, height: geo.size.height)
//            }
//            .background(Color("Primary Black"))
          HStack{
//            Text("GENERAL MOTORS")
//              .background(Color(("Primary Blue")))
//              .foregroundColor(.white)
//              .font(.system(size: 45))
              GeometryReader { geo in
                  Image("Image")
                      .resizable()
                      .scaledToFill()
//                      .scaleEffect(0.5)
//                      .frame(width: 60.0, height: 60.0)
                      .aspectRatio(contentMode: .fit)
              }
          }
          Spacer()
          
          //Horizontal stack to have bottons layout side by side
          HStack{
              NavigationLink("", destination: MyAccountView(), isActive: $navigatedMyAccount)
              NavButtons(text: "My Account", color: Color(("Accent Blue")), topPadding: 40, action: {
                  self.navigatedMyAccount.toggle()
            })
            
              NavigationLink("", destination: VehicleChargeView(vehicleCharge: 0.0), isActive: $navigatedVehicleCharge)
              NavButtons(text: "Vehicle Charge", color: Color(("Accent Blue")), topPadding: 40, action: {
                  self.navigatedVehicleCharge.toggle()
                  
              })
          }
            //Fix this mess I made Chiyou
          HStack{
            NavigationLink("", destination: MapView(), isActive: $navigated)
            NavButtons(text: "Charging Stations", color: Color(("Accent Blue")), topPadding: 40, action: {
              //take to charging stations page
                self.navigated.toggle()
            })
              
            
            NavButtons(text: "Grid Needs", color: Color(("Accent Blue")), topPadding: 40, action: {
            })
            
          }
          
          HStack{
            
            NavButtons(text: "Energy Demand", color: Color(("Accent Blue")), topPadding: 40, action: {
              //take to energy demand page
            })
            
              NavButtons(text: "Payment History", color: Color(("Accent Blue")), topPadding: 40, action: {
              //take to payment history page
                openURL(URL(string: "https://www.paypal.com/us/home")!)
            })
            
          }
            
            
          
          Button(action: signUserOut) {
            Text("Logout")
          }
          .foregroundColor(.white)
          .frame(width: 300, height: 50)
          .background(Color("Accent Blue"))
          .cornerRadius(10)
          
        }
        .background(Color("Primary Black"))
        
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
