//
//  GoogleMapsViewRepresentable.swift
//  Vehicle to Grid
//
//  Created by Joseph on 3/3/23.
//
import Foundation
import GoogleMaps
import GoogleMapsUtils
import SwiftUI

struct GoogleMapsViewRepresentable: UIViewRepresentable {
  let camera: GMSCameraPosition
  @Binding var markers: [GMSMarker]
  @Binding var gridNeedPoints: [GridNeedPoint]  // Add this property to bind to the grid need points array

  func makeUIView(context: Context) -> GMSMapView {
    let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
    mapView.settings.zoomGestures = true
    return mapView
  }

  func updateUIView(_ uiView: GMSMapView, context: Context) {

    markers.forEach { $0.map = uiView as GMSMapView }
    let heatmapLayer = GMUHeatmapTileLayer()
    addGridNeedPoints(to: heatmapLayer)

    heatmapLayer.map = uiView
  }

  func addGridNeedPoints(to heatmapLayer: GMUHeatmapTileLayer) {
    var list = [GMUWeightedLatLng]()
    for point in gridNeedPoints {
      let weightedPoint = GMUWeightedLatLng(
        coordinate: point.coordinates,
        intensity: Float(point.costRatio) / 1.3
      )
      list.append(weightedPoint)

      print(point.zipCode, point.costRatio)

    }

    let gradientColors: [UIColor] = [.green, .red]
    let gradientStartPoints: [NSNumber] = [0.5, 0.75]

    heatmapLayer.gradient = GMUGradient(
      colors: gradientColors,
      startPoints: gradientStartPoints,
      colorMapSize: 256
    )

    heatmapLayer.opacity = 1.0
    heatmapLayer.maximumZoomIntensity = 13
    heatmapLayer.minimumZoomIntensity = 8
    heatmapLayer.radius = 100
      
    //List Set up After
    heatmapLayer.weightedData = list
    print("heatmapLayer.weightedData set successfully")
    print("List of GMUWeightedLatLng objects created: \(list)")
    
    
    
  }
}
