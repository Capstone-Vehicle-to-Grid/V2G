//
//  HistoricalRate.swift
//  Vehicle to Grid
//
//  Created by Joseph on 4/20/23.
//

import Foundation

struct HistoricalRate: Codable {
  struct Inputs: Codable {
    let lat: String
    let lon: String
  }

  struct Outputs: Codable {
    let company_id: String
    let utility_name: String
    struct UtilityInfo: Codable {
      let company_id: String
      let utility_name: String
    }
    let utility_info: [UtilityInfo]
    let commercial: Double
    let industrial: Double
    let residential: Double
  }

  let inputs: Inputs
  let errors: [String]
  let warnings: [String]
  let version: String
  let metadata: [String: [String]]
  let outputs: Outputs
}
