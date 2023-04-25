//
//  UpdateView.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/11/23.
//

import SwiftUI

struct AddInfoView: View {
  
  @StateObject var viewModel = UserViewModel()
  @State private var showAlert = false
  @State var isLoggedIn = false
  @State var showAddInfoView: Bool = false
  
  
  var body: some View {
      ZStack{
          Color("Primary Black").ignoresSafeArea() // sets background color, zstack allows for it to be under fields
          VStack{
              Text("Add Account Information")
                  .font(.custom("overpass-semibold", size: 30))
                  .foregroundColor(Color("Accent Blue"))
                  .bold()
                  .padding()
              
              TextField("General Motors Vehicle Make", text: $viewModel.user.vehicleMake)
                  .padding()
                  .frame(width: 350, height: 50)
                  .background(Color("Accent Gray").opacity(0.70))
                  .font(.custom("overpass-light", size: 16))
              //          .cornerRadius(10)
              
              TextField("General Motors Vehicle Model", text: $viewModel.user.vehicleModel)
                  .padding()
                  .frame(width: 350, height: 50)
                  .background(Color("Accent Gray").opacity(0.70))
                  .font(.custom("overpass-light", size: 16))
              //          .cornerRadius(10)
              
              TextField("General Motors Vehicle VIN", text: $viewModel.user.vehicleVIN)
                  .padding()
                  .frame(width: 350, height: 50)
                  .background(Color("Accent Gray").opacity(0.70))
                  .font(.custom("overpass-light", size: 16))
              //
              NavigationLink(destination: MainView(), isActive: $isLoggedIn){
                  Button(action: {
                      addInfo()
                      self.isLoggedIn = viewModel.logIn()
                  }) {
                      Text("Update Information")
                          .foregroundColor(Color("Accent Blue"))
                          .font(.custom("overpass-light", size: 20))
                          .frame(width: 200, height: 40)
                          .alert(isPresented: $showAlert) {
                              Alert(
                                
                                title: Text("Incomplete Fields"),
                                message: Text("You must complete all fields"),
                                dismissButton: .default(Text("Ok"))
                              )
                          }
                  }}
              
              NavigationLink(destination: MainView(), isActive: $isLoggedIn){
                  Button(action: {
                      self.isLoggedIn = viewModel.logIn()
                      if self.isLoggedIn == false{
                          self.showAlert = true
                      }
                  }) {
                      Text("Skip This Step")
                          .foregroundColor(Color("Accent Blue"))
                          .font(.custom("overpass-light", size: 20))
                          .frame(width: 200, height: 40)
                          .alert(isPresented: $showAlert) {
                              Alert(
                                
                                title: Text("Error Logging In"),
                                message: Text("You were unable to be logged in at this time. Return to the log in screen and try again."),
                                dismissButton: .default(Text("Ok"))
                              )
                          }
                  }}
          }
    }
      
  }
  
  func addInfo(){
    if (viewModel.user.vehicleModel == "" || viewModel.user.vehicleMake == "" || viewModel.user.vehicleVIN == ""){
      showAlert = true
    }
    else{
      viewModel.addInfo()
    }
  }
}

struct AddInfoView_Previews: PreviewProvider {
  static var previews: some View {
    AddInfoView()
  }
}
