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
    @Binding var markers: [GMSMarker]
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        markers.forEach { $0.map = uiView as GMSMapView }
    }
    
}
