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

    @State var markers: [GMSMarker] = []
    
    @State var zoomInCenter: Bool = false
    @State var expandList: Bool = false
    @State var selectedMarker: GMSMarker?
    @State var yDragTranslation: CGFloat = 0
    
    var body: some View{
        //let scrollViewHeight: CGFloat = 80

        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Map
                if let userLocation = viewModel.userLocation {
                    let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 6.0)
                    GoogleMapsViewRepresentable(camera: camera, markers: $markers)
                } else {
                    Text("Loading...")
                }
            }
            .onReceive(viewModel.$stations) { stations in
                markers = stations.map {
                    let marker = GMSMarker(position: $0.coordinate)
                    marker.title = $0.name
                    print("Marker added at \($0.coordinate.latitude), \($0.coordinate.longitude) with name \($0.name)")
                    return marker
                }
            }
            
        }
    }
}

struct ChargingStationsList: View {
    // Use a binding to the computed property in MapView
    @Binding var markers: [GMSMarker]
    var buttonAction: (GMSMarker) -> Void
    var handleAction: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // …
                // List of Charging Stations
                List {
                    ForEach(0..<self.markers.count) { id in
                        let marker = self.markers[id]
                        Button(action: { buttonAction(marker) }) {
                            Text(marker.title ?? "")
                        }
                    }
                }.frame(maxWidth: .infinity)
            }
        }
    }
}
