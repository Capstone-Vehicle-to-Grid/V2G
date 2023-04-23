//
//  UpdateView.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/11/23.
//

import SwiftUI

struct UpdateView: View {
    @StateObject var viewModel = UserAccountViewModel()
    @State private var showAlert = false
    @State private var blankField = false
    @State private var updatedUser = false

    var body: some View {
        
        VStack{
            Text("Update Information")
              .font(.custom("overpass-semibold", size: 40))
              .foregroundColor(Color("Primary Blue"))
              .bold()
              .padding()
              .onAppear{
                  let _ = viewModel.getUserData() }
            
            Text("Account Information")
                .font(.custom("overpass-semibold", size: 20))
                .foregroundColor(Color("Primary Blue"))
                .bold()
                .padding()
            
            TextField("New Username", text: $viewModel.user.username)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            TextField("New Email", text: $viewModel.user.userEmail)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            TextField("New Password", text: $viewModel.user.password)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)

            Text("Vehicle Information")
                .font(.custom("overpass-semibold", size: 20))
                .foregroundColor(Color("285 C"))
                .bold()
                .padding()
            
            TextField("Vehicle Make", text: $viewModel.user.vehicleMake)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            TextField("Vehicle Model", text: $viewModel.user.vehicleModel)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            TextField("Vehicle VIN", text: $viewModel.user.vehicleVIN)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            Button(action: updateInfo) {
                Text("Update Information")
                    .foregroundColor(Color("285 C"))
                    .font(.custom("overpass-light", size: 20))
                    .frame(width: 200, height: 40)
                    .alert(isPresented: $showAlert, content: { self.pickAlert()})
            }
        }
    }
    
    
    func updateInfo(){
        self.blankField = false
        self.updatedUser = false
        if (viewModel.user.username == "" || viewModel.user.userEmail == "" || viewModel.user.password == ""){
            self.blankField = true
        }
        else{
            viewModel.updateInfo()
            self.updatedUser = true
        }
        self.showAlert = true
    }
    
    func pickAlert() -> Alert{
        if blankField == true{
            return Alert(
                title: Text("Blank fields"),
                message: Text("You cannot update your account information if you leave fields blank. Please make sure all fields are completed."),
                dismissButton: .default(Text("Ok")))
        }
        if updatedUser == true{
            return Alert(
                title: Text("Update Successful"),
                message: Text("Your account information was updated successfully. Please select the back button to return to the account page."),
                dismissButton: .default(Text("Ok")))
        }
        return Alert(
            title: Text("Error Updating"),
            message: Text("Your account information was unable to be updated."),
            dismissButton: .default(Text("Ok")))
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}
