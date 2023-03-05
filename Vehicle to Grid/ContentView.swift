//
//  ContentView.swift
//  Vehicle to Grid
//
//  Created by Ben Worthington on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //VStack {
        //    Image(systemName: "globe")
        //        .imageScale(.large)
        //        .foregroundColor(.accentColor)
        //    Text("Hello, world!")
        //}
        //.padding()
        NavigationStack{
            List{
                NavigationLink(destination: MapView()){
                    Text("Map")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
