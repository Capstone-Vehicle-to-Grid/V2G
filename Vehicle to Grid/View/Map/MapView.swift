//
//  MapView.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 2/11/23.
//

import GoogleMaps
import SwiftUI
import UIKit
import GoogleMapsUtils

struct MapView: View {
  @ObservedObject var viewModel = MapViewModel()
  @State var markers: [GMSMarker] = []
  @State var zoomInCenter: Bool = false
  @State var expandList: Bool = false
  @State var selectedMarker: GMSMarker?
  @State var yDragTranslation: CGFloat = 0

  var body: some View {
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

        //This is a crude filtering function and should probably be replaced with GoogleMapsUtils GMUClusterManager at some point in the near future

        let minDistance = 100.0  // Minimum distance between markers in feet
        var filteredStations = [ChargingStation]()

        for station in stations {
          let isTooClose =
            filteredStations.first { otherStation in
              let distance = CLLocation(
                latitude: station.coordinate.latitude,
                longitude: station.coordinate.longitude
              ).distance(
                from: CLLocation(
                  latitude: otherStation.coordinate.latitude,
                  longitude: otherStation.coordinate.longitude
                ))

              return distance < minDistance / 3.281  // Convert feet to meters
            } != nil

          if !isTooClose {
            filteredStations.append(station)
          }
        }

        markers = filteredStations.map {
          let marker = GMSMarker(position: $0.coordinate)
          marker.title = $0.name + " Station"
          marker.isDraggable = false
          return marker
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
            List {
                ForEach(0..<self.markers.count, id: \.self) { id in
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
