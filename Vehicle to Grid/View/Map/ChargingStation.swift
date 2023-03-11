//
//  ChargingStation.swift
//  Vehicle to Grid
//
//  Created by Chiyou Vang on 3/10/23.
//
import CoreLocation

struct ChargingStation: Codable {

  // Define properties for name and coordinate
  var name: String
  var coordinate: CLLocationCoordinate2D

  // Define coding keys to map JSON keys to property names
  enum CodingKeys: String, CodingKey {
    case name = "station_name"
    case latitude
    case longitude
  }

  // Define an initializer that takes a decoder and decodes the JSON data
  init(from decoder: Decoder) throws {

    // Get the container for the coding keys
    let container = try decoder.container(keyedBy: CodingKeys.self)

    // Decode the name from the container
    self.name = try container.decode(String.self, forKey: .name)

    // Decode the latitude and longitude from the container
    let latitude = try container.decode(Double.self, forKey: .latitude)
    let longitude = try container.decode(Double.self, forKey: .longitude)

    // Create a coordinate object from the latitude and longitude
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(name, forKey: .name)
    try container.encode(coordinate.latitude, forKey: .latitude)
    try container.encode(coordinate.longitude, forKey: .longitude)
  }
}
