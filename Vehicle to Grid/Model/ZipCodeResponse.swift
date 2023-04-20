//
//  ZipCodeResponse.swift
//  Vehicle to Grid
//
//  Created by Joseph on 4/19/23.
//

import Foundation
struct ZipcodeResponse: Codable {
  let query: ZipcodeQuery
  let results: [NearbyZipcodeObject]
}

struct ZipcodeQuery: Codable {
  let code: String
  let unit: String
  let radius: String
  let country: String
}

struct NearbyZipcodeObject: Codable {
  let code: String
  let city: String
  let state: String
  let distance: Double
}
