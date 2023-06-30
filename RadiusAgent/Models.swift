//
//  Models.swift
//  RadiusAgent
//
//  Created by Raj  Dhakate on 30/06/23.
//

import Foundation

struct FacilitiesData: Codable, Hashable {
    var facilities: [Facility] = []
    var exclusions: [[Exclusion]] = []
}

struct Facility: Codable, Hashable {
    var facilityID: String
    var options: [FacilityOption]
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case options, name
        case facilityID = "facility_id"
    }
}

struct FacilityOption: Codable, Hashable {
    var id: String
    var name: String
    var icon: String
}

struct Exclusion: Codable, Hashable {
    var facilityID: String = ""
    var optionsID: String = ""
    
    enum CodingKeys: String, CodingKey {
        case optionsID = "options_id"
        case facilityID = "facility_id"
    }
}
