//
//  PaymentView.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/11/23.
//

import SwiftUI

struct PaymentView: View {
    //    @StateObject var viewModel = userPaymentViewModel()
    @Environment(\.openURL) var openURL
    var body: some View {
        NavigationView {
            HStack{
                
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Current Balance: $25")
                        .font(.headline)
                        .foregroundColor(Color("Accent Blue"))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack{
                        
                        Divider() // Add a horizontal line as a section separator
                        
                        Text("Please login to PayPal to withdraw funds")
                            .foregroundColor(Color("Accent Blue"))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    
                    VStack{
                        
                        Divider() // Add a horizontal line as a section separator
                        
                        VStack{
                            
                            Text("You received $15.00")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("On 10/10/2022")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Transaction #: 0011")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        
                        VStack{
                            
                            Text("You received $5.00")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("On 11/15/2022")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Transaction #: 0022")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        
                        VStack{
                            
                            Text("You received $5.00")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("On 1/9/2023")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Transaction #: 0033")
                                .foregroundColor(Color("Accent Blue"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()

                    }
                    
                    Spacer()
                    Button {
                        openURL(URL(string: "https://www.paypal.com/us/home")!)
                        print("PayPal")
                    } label: {
                        Label("PayPal", systemImage: "creditcard")
                    }
                    .foregroundColor(Color("Accent Blue"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    Spacer()
                    
                }
                
                Spacer()
            }
            .background(Color("Primary Black")) //Change background color so its under
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

