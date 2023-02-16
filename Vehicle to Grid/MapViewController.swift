//
//  MapViewController.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 2/14/23.
//

import GoogleMaps
import UIKit
import SwiftLocation

class MapViewController: UIViewController {

  override func loadView() {
    super.loadView()
      
    SwiftLocation.gpsLocation().then {
        if let location = $0.location{
            let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            mapView.isMyLocationEnabled = true
            self.view.addSubview(mapView)
            
            //let marker = GMSMarker()
            //marker.position = location.coordinate
            //marker.title = "You"
            //marker.map = mapView
        }
        else{
            print("Could not get location")
            
            let camera = GMSCameraPosition.camera(withLatitude:32.7767, longitude: 96.797, zoom: 6.0)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.view.addSubview(mapView)
        }
    }
  }
}
