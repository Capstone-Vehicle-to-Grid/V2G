//
//  MapView.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 2/11/23.
//

import GoogleMaps
import GoogleMapsUtils
import SwiftUI
import UIKit

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
                    GoogleMapsViewRepresentable(
                        camera: camera, markers: $markers, gridNeedPoints: $viewModel.gridNeedPoints)  // Pass the gridNeedPoints array as a binding
                } else {
                    Text("Loading...")
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
