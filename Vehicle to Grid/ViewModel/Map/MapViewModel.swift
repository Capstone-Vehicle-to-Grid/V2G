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
  @Published var stations = [ChargingStation]()

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
      self.fetchStations()
    }
  }

  func fetchStations() {
    guard let userLocation = userLocation else {
      print("User location is nil")
      return
    }

    var urlComponents = URLComponents(
      string: "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json")!

    urlComponents.queryItems = [
      URLQueryItem(name: "api_key", value: "I4jcAw9YJbzYyYZLJKubl4J67TNtnXMgS0WFchtj"),
      URLQueryItem(name: "location", value: "\(userLocation.latitude),\(userLocation.longitude)"),
    ]

    // Get the final URL from the components
    let url = urlComponents.url!

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in

      if let error = error {
        print("Error fetching stations: \(error)")
        return
      }

      // Check if there is data and response status code is 200
      guard let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200
      else {
        print("Invalid data or response")
        return
      }

      // Try to decode the data as an array of ChargingStation objects
      do {
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]

        if let stationsArray = json?["fuel_stations"] as? [[String: Any]] {
          let stationsData = try JSONSerialization.data(withJSONObject: stationsArray)

          let stations = try JSONDecoder().decode([ChargingStation].self, from: stationsData)

          // Update the stations property on the main thread
          DispatchQueue.main.async {
            self.stations = stations
          }
        }
      } catch {
        print("Error decoding stations: \(error)")
      }
    }
    task.resume()
  }
}

