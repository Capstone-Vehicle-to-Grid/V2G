//
//  HomePageView.swift
//  Vehicle to Grid
//
//  Created by David Hammons on 2/25/23.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        VStack{
            HStack{
                Text("GENERAL MOTORS")
                    .background(Color .blue)
                    .foregroundColor(.white)
                    .font(.system(size: 45))
                
                //                .frame(width: 300, height: 300, alignment: .topLeading)
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
            
            HStack{
                NavButtons(text: "Charging Stations", color: .blue, topPadding: 40, action: {
                    //take to charging stations page
                })
                NavButtons(text: "Grid Needs", color: .blue, topPadding: 40, action: {
                    //take to grid needs page
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

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
