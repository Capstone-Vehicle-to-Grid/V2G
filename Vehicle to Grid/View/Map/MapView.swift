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
                var i = 0
                markers = filteredStations.map {
                    let marker = GMSMarker(position: $0.coordinate)
                    let markerStation = filteredStations[i]
                    let info = getInfo(markerStation: markerStation)
                    marker.title = $0.name + " Station"
                    marker.snippet = info
                    marker.isDraggable = false
                    i += 1
                    return marker
                }
                
            }
            
        }
        
    }
    func getInfo(markerStation: ChargingStation) -> String {
        let markerStationDict = viewModel.poiDictionary[markerStation.name]
        let address = markerStationDict?.address
        var info = ""
        if (address?.addressLine2 == "" || address?.addressLine2 == nil){
            info = ("Address:\n\(address?.addressLine1 ?? "Not found")\n" + "\(address?.town ?? ""), " + "\(address?.stateOrProvince ?? "")\n" + "\(address?.postcode ?? "")\n" +
                    "\nHours: " +
                    "\nCurrent Price: ")
        }
        else {
            info = ("Address:\n \(address?.addressLine1 ?? "Not found")\n" + "\(address?.addressLine2 ?? "")\n" + "\(address?.town ?? ""), " + "\(address?.stateOrProvince ?? "")\n" + "\(address?.postcode ?? "")\n" +
                    "\nHours: " +
                    "\nCurrent Price: ")}
        return info
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
