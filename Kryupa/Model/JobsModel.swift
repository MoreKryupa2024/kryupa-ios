//
//  JobsModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import Foundation

// MARK: - Empty
struct JobsModel: Codable {
    let data: JobsData
    let message: String
    let success: Bool
}

// MARK: - DataClass
struct JobsData: Codable {
    let jobPost: [JobPost]
}

// MARK: - JobsNearYou
struct JobPost: Codable {
    let customerInfo: CustomerInfoData
    let bookingDetails: BookingDetailsData
    
}

struct CustomerInfoData: Codable {
    let name, gender, price: String
    let diseaseType: [String]
}

struct BookingDetailsData: Codable {
    let areaOfExpertise: [String]
    let bookingType, startDate, endDate, startTime, endTime: String
}

