//
//  MyAccountView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 4/6/23.
//
import SwiftUI
import Foundation
import FirebaseFirestore

struct MyAccountView: View {
    @StateObject var viewModel = UserAccountViewModel()
//    @State private var userPhone: String = ""
    
    var body: some View {
        
        NavigationView {
            HStack{
                
                VStack(alignment: .leading) {
                    Text(viewModel.user.username)
                        .font(.headline)
                        .foregroundColor(Color("Accent Blue"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .onAppear{
                            let _ = viewModel.getUserData() }
                    
                    VStack{
                        
                        Divider() // Add a horizontal line as a section separator
                            .background(Color("Accent Blue"))
                        
                            Text("User Info")
                            .font(.headline)
                            .foregroundColor(Color("Accent Blue"))
                        
                            Text("Name: \(viewModel.user.username)")
                            .foregroundColor(Color("Accent Blue"))
                            .padding(5)
                            Text("Email: \(viewModel.user.userEmail)")
                            .foregroundColor(Color("Accent Blue"))
                            
                        }
                    
                    VStack{

                        Divider() // Add a horizontal line as a section separator
                            .background(Color("Primary Blue"))
                        
                        Text("Vehicle Info")
                            .font(.headline)
                            .foregroundColor(Color("Accent Blue"))
                        
                        Text("Model: \(viewModel.user.vehicleModel)")
                            .foregroundColor(Color("Accent Blue"))
                            .padding(5)
                        Text("Make: \(viewModel.user.vehicleMake)")
                            .foregroundColor(Color("Accent Blue"))
                            .padding(5)
                        Text("VIN: \(viewModel.user.vehicleVIN)")
                            .foregroundColor(Color("Accent Blue"))
                        
                    }
                    
                    Spacer()
                        .frame(height: 30)
                    
                    NavigationLink(destination: UpdateView()) {
                      Text("Update User Information")
                        .font(.custom("overpass-light", size: 20))
                        .foregroundColor(Color("Accent Blue"))
                        .frame(width: 400, height: 40, alignment: .center)
                    }
                        
                        Spacer()
                    
                    }
                
                    Spacer()
                }
            .background(Color("Primary Black")) //Change background color so its under
            }
        }
    }
    
    

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
