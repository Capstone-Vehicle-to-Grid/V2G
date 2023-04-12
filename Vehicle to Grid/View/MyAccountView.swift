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
                    Text("User Name")
                        .font(.headline)
                        .foregroundColor(Color("311 C"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    VStack{
                        
                        Divider() // Add a horizontal line as a section separator
                            .background(Color("285 C"))
                        
                            Text("User Info")
                            .font(.headline)
                            .foregroundColor(Color("311 C"))
                            .onAppear{
                                let _ = viewModel.getUserData()
                            }
                            Text("Name: \(viewModel.user.username)")
                            .foregroundColor(Color("311 C"))
                            .padding(5)
                            Text("Email: \(viewModel.user.userEmail)")
                            .foregroundColor(Color("311 C"))
                            
                        }
                    
                    VStack{

                        Divider() // Add a horizontal line as a section separator
                            .background(Color("285 C"))
                        
                        Text("Vehicle Info")
                            .font(.headline)
                            .foregroundColor(Color("311 C"))
                        
                        Text("Year: 2023")
                            .foregroundColor(Color("311 C"))
                            .padding(5)
                        Text("Model: Cadillac LYRIQ")
                            .foregroundColor(Color("311 C"))
                            .padding(5)
                        Text("VIN: JJ1PMVC43T5571234")
                            .foregroundColor(Color("311 C"))
                        
                    }
                    
                    VStack{
                        
                        Divider() // Add a horizontal line as a section separator
                            .background(Color("285 C"))
                        
                        Text("Banking Info")
                            .font(.headline)
                            .foregroundColor(Color("311 C"))
                        
                        Text("Bank: Bank")
                            .foregroundColor(Color("311 C"))
                            .padding(5)
                        Text("Routing: 111111")
                            .foregroundColor(Color("311 C"))
                            .padding(5)
                        Text("Account: 222222")
                            .foregroundColor(Color("311 C"))
                        
                    }
                        
                        Spacer()
                    
                    }
                
                    Spacer()
                }
            .background(Color("Black 7 C")) //Change background color so its under
            }
        }
    }
    
    

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
