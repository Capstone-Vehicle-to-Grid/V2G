//
//  OpenChargeMapPOI.swift
//  Vehicle to Grid
//
//  Created by Joseph on 4/13/23.
//

import Foundation

public class OpenChargeMapPOI : Codable {
    var id: Int?
    var address: AddressInfo?
    var operatorInfo: OperatorInfo?
    var distance: Float?
    var usageCost: String?

    enum CodingKeys : String, CodingKey {
      case id = "ID"
      case address = "AddressInfo"
      case distance = "Distance"
      case usageCost = "UsageCost"
      case operatorInfo = "OperatorInfo"
    }
    
    public class OperatorInfo: Codable {
        let websiteURL: URL?
        let phonePrimaryContact: String?
        let phoneSecondaryContact: String?
        let contactEmail: String?
        let id: Int?
        let title: String?

        enum CodingKeys: String, CodingKey {
            case websiteURL = "WebsiteURL"
            case phonePrimaryContact = "PhonePrimaryContact"
            case phoneSecondaryContact = "PhoneSecondaryContact"
            case contactEmail = "ContactEmail"
            case id = "ID"
            case title = "Title"
        }
        
    }

    public class AddressInfo : Codable, CustomStringConvertible {
      var title: String?
      var addressLine1: String?
      var addressLine2: String?
      var town: String?
      var stateOrProvince: String?
      var postcode: String?
      var countryID: Int?
      var country: Country?

      enum CodingKeys : String, CodingKey {
        case title = "Title"
        case addressLine1 = "AddressLine1"
        case addressLine2 = "AddressLine2"
        case town = "Town"
        case stateOrProvince = "StateOrProvince"
        case postcode = "Postcode"
        case countryID = "CountryID"
        case country = "Country"
      }

      public class Country : Codable {
        var isoCode: String?
        var continentCode: String?
        var title: String?

        enum CodingKeys : String, CodingKey {
          case isoCode = "ISOCode"
          case continentCode = "ContinentCode"
          case title = "Title"
        }
      }

      public var description: String {
        var result = ""
        if let title = title {
          result += "\(title)\n"
        }
        if let addressLine1 = addressLine1 {
          result += "\(addressLine1)\n"
        }
        if let addressLine2 = addressLine2 {
          result += "\(addressLine2)\n"
        }
        if let town = town {
          result += "\(town), "
        }
        if let stateOrProvince = stateOrProvince {
          result += "\(stateOrProvince) "
        }
        if let postcode = postcode {
          result += "\(postcode)\n"
        }
        if let country = country {
          result += "\(country.title ?? "")\n"
        }
        return result
      }
    }
  }

