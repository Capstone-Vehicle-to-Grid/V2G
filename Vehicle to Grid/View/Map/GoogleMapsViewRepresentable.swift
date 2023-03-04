//
//  GoogleMapsViewRepresentable.swift
//  Vehicle to Grid
//
//  Created by Joseph on 3/3/23.
//

import Foundation
import GoogleMaps
import SwiftUI

struct GoogleMapsViewRepresentable: UIViewRepresentable {
    let camera: GMSCameraPosition
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
