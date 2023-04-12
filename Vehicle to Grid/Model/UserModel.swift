//
//  UserModel.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 2/20/23.
//

import Foundation
import FirebaseFirestoreSwift

typealias Users = [User]

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var password: String
    var userEmail: String
    var vehicleMake: String
    var vehicleModel: String
    var vehicleVIN: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case password
        case userEmail
        case vehicleMake
        case vehicleModel
        case vehicleVIN
    }
}
