//
//  MainView.swift
//  Vehicle to Grid
//
//  Created by Ben Worthington on 2/18/23.
//

import SwiftUI

struct MainView: View {
  
  // Properties
  @State var isLoggedIn: Bool = false
  
    var body: some View {
      
      NavigationView {
        if isLoggedIn {
          
          // Stay on this screen
          Text("Main Screen")
          
          
        } else {
          
          // Back to login screen
          LoginView(isLoggedIn: $isLoggedIn)
          
        }
      }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
