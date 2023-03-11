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
    //Test List
    static let chargingStations = [
        ChargingStation(name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7576, longitude: -122.4194)),
        ChargingStation(name: "Seattle", coordinate: CLLocationCoordinate2D(latitude: 47.6131742, longitude: -122.4824903)),
        ChargingStation(name: "Singapore", coordinate: CLLocationCoordinate2D(latitude: 1.3440852, longitude: 103.6836164)),
        ChargingStation(name: "Sydney", coordinate: CLLocationCoordinate2D(latitude: -33.8473552, longitude: 150.6511076)),
        ChargingStation(name: "Tokyo", coordinate: CLLocationCoordinate2D(latitude: 35.6684411, longitude: 139.6004407))
      ]

      @State var markers: [GMSMarker] = chargingStations.map {
        let marker = GMSMarker(position: $0.coordinate)
        marker.title = $0.name
        return marker
      }
    
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
        }
    }
}

struct ChargingStationsList: View {

  @Binding var markers: [GMSMarker]
  var buttonAction: (GMSMarker) -> Void
  var handleAction: () -> Void


  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        // ...
        // List of Charging Stations
        List {
          ForEach(0..<self.markers.count) { id in
            let marker = self.markers[id]
            Button(action: {
              buttonAction(marker)
            }) {
              Text(marker.title ?? "")
            }
          }
        }.frame(maxWidth: .infinity)
      }
    }
  }
}
