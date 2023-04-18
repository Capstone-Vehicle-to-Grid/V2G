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

  //Dictionary mapping station names to OpenChargeMapPOI's
  @Published var poiDictionary = [String: OpenChargeMapPOI]()

  init() {
    getUserLocation()
  }

    func getUserLocation() {
      SwiftLocation.gpsLocation().then {
        if let location = $0.location {
          self.userLocation = location.coordinate
            
            self.getZipFromCoordinate(coordinate: self.userLocation!) { zipCode in
            if let zipCode = zipCode {
              print(zipCode)
            } else {
              print("Could not get zip code")
            }
          }
            
        } else {
          print("Could not get location")
          self.userLocation = CLLocationCoordinate2D(latitude: 32.7767, longitude: 96.797)
        }
          
        self.fetchStations { stations in
          self.updatePOIDictionary(with: stations)
        }
      }
    }

  // Modify the fetchStations method to accept a completion handler as a parameter
  func fetchStations(completion: @escaping ([ChargingStation]) -> Void) {
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

            // Call the completion handler with the stations array
            completion(stations)
          }
        }
      } catch {
        print("Error decoding stations: \(error)")
      }
    }
    task.resume()
  }

  func updatePOIDictionary(with stations: [ChargingStation]) {

    let group = DispatchGroup()

    for station in stations {

      group.enter()

      var components = URLComponents(string: "https://api.openchargemap.io/v3/poi/")!
      components.queryItems = [
        URLQueryItem(name: "key", value: "fbcf6c48-38fd-488c-9d4a-d29a074d6c7e"),
        URLQueryItem(name: "latitude", value: "\(station.coordinate.latitude)"),
        URLQueryItem(name: "longitude", value: "\(station.coordinate.longitude)"),
        URLQueryItem(name: "distance", value: ".1"),
        URLQueryItem(name: "distanceunit", value: "Miles"),
        URLQueryItem(name: "maxresults", value: "1"),
      ]
      let url = components.url!

      let task = URLSession.shared.dataTask(with: url) { data, response, error in

        if let error = error {
          print("Error fetching data from OpenChargeMap API: \(error.localizedDescription)")
        }

        // If there is data, decode it into an array of OpenChargeMapPOI objects
        else if let data = data {
          do {
            let decoder = JSONDecoder()
            let powerStations = try decoder.decode([OpenChargeMapPOI].self, from: data)

            if let powerStation = powerStations.first {

              DispatchQueue.main.async {
                self.poiDictionary[station.name] = powerStation
              }
            }
          }

          // If there is a decoding error, print a message and do nothing
          catch {
            print("Error decoding data from OpenChargeMap API: \(error.localizedDescription)")
          }
        }

        group.leave()
      }

      task.resume()
    }
  }
    
    func getZipFromCoordinate(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
      let geocoder = CLGeocoder()
      let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
      geocoder.reverseGeocodeLocation(location) { placemarks, error in
        if let placemark = placemarks?.first {
          if let zipCode = placemark.postalCode {
            completion(zipCode)
          } else {
            print("No zip code found")
            completion(nil)
          }
        } else {
          print("Geocoder failed: \(error?.localizedDescription ?? "unknown error")")
          completion(nil)
        }
      }
    }


}
