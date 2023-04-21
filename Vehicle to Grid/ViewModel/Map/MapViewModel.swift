//
//  MapViewModel.swift
//  Vehicle to Grid
//
//  Created by Joseph on 3/3/23.
//

import Foundation
import GameplayKit
import GoogleMaps
import SwiftLocation

class MapViewModel: ObservableObject {
  @Published var userLocation: CLLocationCoordinate2D?
  @Published var stations = [ChargingStation]()
  @Published var gridNeedPoints = [GridNeedPoint]()
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

            self.getNearbyZipCodes(zipCode: zipCode) { zipCodes in
              for zipCode in zipCodes {
                self.getCoordinateFromZipCode(zipCode: zipCode) { coord in
                  // Fetch the historical rate from NREL for the coordinate
                  self.getHistoricalRate(lat: coord.latitude, lng: coord.longitude) {
                    historicalRate in

                    if let historicalRate = historicalRate {
                      // Generate 10 points per zip code
                      for _ in 1...3 {
                        // Generate a random offset for the latitude and longitude
                        let latOffset = Double.random(in: -0.09...0.09)
                        let lngOffset = Double.random(in: -0.09...0.09)
                        // Create a new coordinate with the offset
                        let newCoord = CLLocationCoordinate2D(
                          latitude: coord.latitude + latOffset,
                          longitude: coord.longitude + lngOffset
                        )
                        // Generate the grid need ratio with Perlin noise for the new coordinate and a random seed
                        let ratio = self.generateGridNeedRatio(
                          lat: newCoord.latitude, lng: newCoord.longitude,
                          seed: Int.random(in: 0...100))
                        // Create a GridNeedPoint object with the ratio constructor
                        let gridNeedPoint = GridNeedPoint(
                          zipCode: zipCode, coordinates: newCoord,
                          historicalCost: Double(historicalRate.outputs.commercial),
                          ratio: Double(ratio))

                        print(gridNeedPoint)

                        DispatchQueue.main.async {
                          self.gridNeedPoints.append(gridNeedPoint)
                        }
                      }
                    } else {
                      print("Could not get historical rate")
                    }

                  }
                }
              }
            }

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

  func getZipFromCoordinate(
    coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void
  ) {
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

  func getNearbyZipCodes(zipCode: String, completion: @escaping ([String]) -> Void) {
    let baseUrl = "https://app.zipcodebase.com/api/v1/radius"
    let apiKey = "e5ac92a0-de1d-11ed-a637-67bfb6b78611"

    var urlComponents = URLComponents(string: baseUrl)!
    urlComponents.queryItems = [
      URLQueryItem(name: "apikey", value: apiKey),
      URLQueryItem(name: "code", value: zipCode),
      URLQueryItem(name: "radius", value: "15"),
      URLQueryItem(name: "country", value: "us"),
    ]

    let request = URLRequest(url: urlComponents.url!)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        print("Error: \(error.localizedDescription)")
        return
      }

      guard let data = data, let response = response as? HTTPURLResponse else {
        print("Invalid data or response")
        return
      }

      if response.statusCode == 200 {
        do {
          let decoder = JSONDecoder()
          let zipcodeResponse = try decoder.decode(ZipcodeResponse.self, from: data)
          var zipCodes = [String]()
          for nearbyZipcode in zipcodeResponse.results {
            zipCodes.append(nearbyZipcode.code)
          }
          completion(zipCodes)
        } catch {
          print("JSON decoding error: \(error.localizedDescription)")
        }
      } else {
        print("Request failed with status code: \(response.statusCode)")
      }
    }

    task.resume()
  }

  func getCoordinateFromZipCode(
    zipCode: String, completion: @escaping (CLLocationCoordinate2D) -> Void
  ) {
    let geocoder = CLGeocoder()
    print("Geocoding zip code: \(zipCode)")
    geocoder.geocodeAddressString(zipCode) { placemarks, error in
      if let error = error {
        print("Error: \(error.localizedDescription)")
        return
      }
      if let placemarks = placemarks {
        let placemark = placemarks[0]
        if let coordinate = placemark.location?.coordinate {
          completion(coordinate)
        }
      }
    }
  }

  func getHistoricalRate(lat: Double, lng: Double, completion: @escaping (HistoricalRate?) -> Void)
  {
    let url = URL(
      string:
        "https://developer.nrel.gov/api/utility_rates/v3.json?api_key=I4jcAw9YJbzYyYZLJKubl4J67TNtnXMgS0WFchtj&lat=\(lat)&lon=\(lng)"
    )!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Error: \(error.localizedDescription)")
        completion(nil)
        return
      }
      if let data = data {
        let decoder = JSONDecoder()
        do {
          let historicalRate = try decoder.decode(HistoricalRate.self, from: data)
          completion(historicalRate)
        } catch {
          print("Error: \(error.localizedDescription)")
          completion(nil)
        }
      }
    }
    task.resume()
  }

  // A function that returns a mock ratio of current cost / historical cost for a given lat/lng and seed
  func generateGridNeedRatio(lat: Double, lng: Double, seed: Int) -> Float {
    let noiseSource = GKPerlinNoiseSource()
    noiseSource.seed = Int32(seed)
    let noise = GKNoise(noiseSource)
    let noiseMap = GKNoiseMap(
      noise,
      size: vector_double2(1.0, 1.0),
      origin: vector_double2(0.0, 0.0),
      sampleCount: vector_int2(128, 128),
      seamless: true)
    let value = noiseMap.value(at: vector_int2(Int32(lat), Int32(lng)))

    return 1 + value * 0.3
  }
}
