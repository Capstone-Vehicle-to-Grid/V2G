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
    
    var body: some View {
        
        NavigationView {
            HStack{
                
                VStack(alignment: .leading) {
                    Text("User Name")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    VStack{
                            Text("Profile")
                            .onAppear{
                                let _ = viewModel.getUserData()
                            }
                            Text("Name: \(viewModel.user.username)")
                            Text("Email: \(viewModel.user.userEmail)")
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
