//
//  GoogleMapsViewRepresentable.swift
//  Vehicle to Grid
//
//  Created by Joseph on 3/3/23.
//
import Foundation
import GoogleMaps
import SwiftUI
import GoogleMapsUtils

struct GoogleMapsViewRepresentable: UIViewRepresentable {
    let camera: GMSCameraPosition
    @Binding var markers: [GMSMarker]

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
        
        let heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.map = mapView
        
        print("Heatmap layer added to mapView: \(heatmapLayer.map != nil)")
        
        addHeatmap(to: heatmapLayer)
        
        return mapView
    }
    
    func addHeatmap(to heatmapLayer: GMUHeatmapTileLayer) {
        print("Making HEATMAPPP")
        // Get the data: latitude/longitude positions of police stations.
        guard let path = Bundle.main.url(forResource: "police_stations", withExtension: "json") else {
          return
        }
        guard let data = try? Data(contentsOf: path) else {
          return
        }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
          return
        }
        guard let object = json as? [[String: Any]] else {
          print("Could not read the JSON.")
          return
        }

        var list = [GMUWeightedLatLng]()
        for item in object {
          let lat = item["lat"] as! CLLocationDegrees
          let lng = item["lng"] as! CLLocationDegrees
          let coords = GMUWeightedLatLng(
            coordinate: CLLocationCoordinate2DMake(lat, lng),
            intensity: 10.0
          )
          list.append(coords)
          print(lat, lng)
        }

        // Add the latlngs to the heatmap layer.
        DispatchQueue.main.async {
            heatmapLayer.weightedData = list
            let gradientColors: [UIColor] = [.green, .red]
            let gradientStartPoints: [NSNumber] = [0.2, 1.0]
            heatmapLayer.gradient = GMUGradient(
              colors: gradientColors,
              startPoints: gradientStartPoints,
              colorMapSize: 256
            )
            heatmapLayer.opacity = 0.5
                  
        }
        print("List of GMUWeightedLatLng objects created: \(list)")
        print("Heatmap gradient set: \(heatmapLayer.gradient != nil)")
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        markers.forEach { $0.map = uiView as GMSMapView }
    }
}





