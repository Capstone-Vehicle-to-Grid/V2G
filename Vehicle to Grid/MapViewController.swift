//
//  MapViewController.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 2/14/23.
//

import GoogleMaps
import UIKit

class MapViewController: UIViewController {

  let map =  GMSMapView(frame: .zero)
  var isAnimating: Bool = false

  override func loadView() {
    super.loadView()
    self.view = map
  }
}
