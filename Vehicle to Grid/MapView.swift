//
//  MapView.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 2/11/23.
//

import SwiftUI
import UIKit
import GoogleMaps

struct MapView: View {
    var body: some View{
        
        let scrollViewHeight: CGFloat = 80

          GeometryReader { geometry in
            ZStack(alignment: .top) {
              // Map
              MapViewControllerBridge()
              
              }
            }
          }
    }


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

