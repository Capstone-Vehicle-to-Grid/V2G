//
//  MapViewModel.swift
//  Vehicle to Grid
//
//  Created by Joseph on 3/3/23.
//

import Foundation
import GoogleMaps
import SwiftLocation

class MapViewModel: ObservableObject {
    @Published var userLocation: CLLocationCoordinate2D?
    
    init() {
        getUserLocation()
    }
    
    func getUserLocation() {
        SwiftLocation.gpsLocation().then {
            if let location = $0.location {
                self.userLocation = location.coordinate
            } else {
                print("Could not get location")
                self.userLocation = CLLocationCoordinate2D(latitude: 32.7767, longitude: 96.797)
            }
        }
    }
}
