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
  @State var navigatedPayment = false
  @Environment(\.openURL) var openURL
    @State var gridNeed: String = "unavailable"
    @StateObject var gridViewModel = MapViewModel()
//  @State var goToAccount = false
  
  var body: some View {
      
    NavigationView {
      
      // If the user is currently logged in, show MainView
      if isLoggedIn {
        VStack{
            
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
              Text("Grid Need: \n\(gridNeed)")
                  .onAppear{
                      getGridNeed()
                  }
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 120)
                .background(Color("Accent Blue"))
                .cornerRadius(30)
                .shadow(radius: 40)
                .padding(.top, 40)
                .padding(.horizontal)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)

            
              NavigationLink("", destination: VehicleChargeView(vehicleCharge: 0.0), isActive: $navigatedVehicleCharge)
              NavButtons(text: "Vehicle Charge", color: Color(("Accent Blue")), topPadding: 40, action: {
                  self.navigatedVehicleCharge.toggle()
                  
              })
          }
            //Fix this mess I made Chiyou
            HStack{
                
                NavigationLink("", destination: MapView(), isActive: $navigated)
                NavButtons(text: "Display Map", color: Color(("Accent Blue")), topPadding: 40, action: {
                    //take to charging stations page
                    self.navigated.toggle()
                })
                
                
            }
            HStack {
                NavigationLink("", destination: PaymentView(), isActive: $navigatedPayment)
                NavButtons(text: "Payment History", color: Color(("Accent Blue")), topPadding: 40, action: {
                    //take to payment history page
                    self.navigatedPayment.toggle()
  //                  openURL(URL(string: "https://www.paypal.com/us/home")!)
                })
                
                NavigationLink("", destination: MyAccountView(), isActive: $navigatedMyAccount)
                NavButtons(text: "My Account", color: Color(("Accent Blue")), topPadding: 40, action: {
                    self.navigatedMyAccount.toggle()
              })
            }
            Spacer()
            Spacer()
            
          
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

    func getGridNeed() {
        if gridViewModel.isInHighGridNeed == false{
            self.gridNeed = "Low"
        }
        
        if gridViewModel.isInHighGridNeed == true {
            self.gridNeed = "HIGH"
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
