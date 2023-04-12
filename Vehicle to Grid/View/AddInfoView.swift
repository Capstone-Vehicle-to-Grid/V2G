//
//  UpdateView.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/11/23.
//

import SwiftUI

struct AddInfoView: View {
    @StateObject var viewModel = UserViewModel()
    @State var loggedIn = true
    @State private var showAlert = false
    
    var body: some View {
        
        VStack{
            Text("Add Account Information")
              .font(.custom("overpass-semibold", size: 40))
              .foregroundColor(Color("285 C"))
              .bold()
              .padding()
            
            TextField("General Motors Vehicle Make", text: $viewModel.user.vehicleMake)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            TextField("General Motors Vehicle Model", text: $viewModel.user.vehicleModel)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //          .cornerRadius(10)
            
            TextField("General Motors Vehicle VIN", text: $viewModel.user.vehicleVIN)
                .padding()
                .frame(width: 350, height: 50)
                .background(Color.black.opacity(0.05))
                .font(.custom("overpass-light", size: 16))
            //
           
            Button(action: addInfo) {
                Text("Update Information")
                    .foregroundColor(Color("285 C"))
                    .font(.custom("overpass-light", size: 20))
                    .frame(width: 200, height: 40)
                    .alert(isPresented: $showAlert) {
                      Alert(
                        
                        title: Text("Incomplete Fields"),
                        message: Text("You must complete all fields"),
                        dismissButton: .default(Text("Ok"))
                      )
                    }
            }
            NavigationLink(destination: MainView(isLoggedIn: loggedIn)) {
              Text("Skip this step")
                .foregroundColor(Color("285 C"))
                .font(.custom("overpass-light", size: 20))
                .frame(width: 200, height: 40)
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
