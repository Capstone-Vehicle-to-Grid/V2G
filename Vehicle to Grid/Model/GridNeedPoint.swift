//
//  GridNeedPoint.swift
//  Vehicle to Grid
//
//  Created by Joseph on 4/19/23.
//

import Foundation
import CoreLocation

// A struct that represents a grid need point
struct GridNeedPoint {
  let zipCode: String // The zip code of the location
  let coordinates: CLLocationCoordinate2D // The latitude and longitude of the location
  let historicalCost: Double // The historical cost of electricity ($/kWh)
  var currentCost: Double // The current cost of electricity ($/kWh)
  var costRatio: Double // The ratio of current cost / historical cost, or grid need, of the point
  
  // A constructor that takes a ratio and calculates the current cost
  init(zipCode: String, coordinates: CLLocationCoordinate2D, historicalCost: Double, ratio: Double) {
    self.zipCode = zipCode
    self.coordinates = coordinates
    self.historicalCost = historicalCost
    // Calculate the current cost by multiplying the historical cost by the ratio
    self.currentCost = historicalCost * ratio
    // Set the cost ratio to the given ratio
    self.costRatio = ratio
  }
  
  // A constructor that takes a current cost and calculates the ratio
  init(zipCode: String, coordinates: CLLocationCoordinate2D, historicalCost: Double, currentCost: Double) {
    self.zipCode = zipCode
    self.coordinates = coordinates
    self.historicalCost = historicalCost
    // Set the current cost to the given current cost
    self.currentCost = currentCost
    // Calculate the ratio by dividing the current cost by the historical cost
    self.costRatio = currentCost / historicalCost
  }
}
