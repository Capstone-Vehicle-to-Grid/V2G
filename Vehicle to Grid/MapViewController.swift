//
//  MapViewController.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 2/14/23.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController {

  override func loadView() {
    super.loadView()
      let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
      let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
      self.view.addSubview(mapView)

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = mapView
  }
}
