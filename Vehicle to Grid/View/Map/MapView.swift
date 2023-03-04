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
    @ObservedObject var viewModel = MapViewModel()
    
    var body: some View{
        let scrollViewHeight: CGFloat = 80

        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Map
                if let userLocation = viewModel.userLocation {
                    let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 6.0)
                    GoogleMapsViewRepresentable(camera: camera)
                } else {
                    Text("Loading...")
                }
            }
        }
    }
}
