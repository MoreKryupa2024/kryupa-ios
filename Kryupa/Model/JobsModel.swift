//
//  JobsModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import Foundation

// MARK: - Empty
/*struct JobsModel: Codable {
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
    let jobId: String
}

struct CustomerInfoData: Codable {
    let name, gender, price: String
    let diseaseType: [String]
}

struct BookingDetailsData: Codable {
    let areaOfExpertise: [String]
    let bookingType, startDate, endDate, startTime, endTime: String
}
*/

struct JobsModel: Codable {
    let data: JobsData
    let message: String
    let success: Bool
}

// MARK: - DataClass
struct JobsData: Codable {
    let jobPost: [JobPost]

    enum CodingKeys: String, CodingKey {
        case jobPost = "job_post"
    }
}

// MARK: - JobPost
struct JobPost: Codable {
    let customerInfo: CustomerInfo
    let bookingDetails: BookingDetails
    let jobID: String

    enum CodingKeys: String, CodingKey {
        case customerInfo, bookingDetails
        case jobID = "job_id"
    }
}

// MARK: - BookingDetails
struct BookingDetails: Codable {
    let areaOfExpertise: [String]
    let bookingType, startDate, endDate, startTime: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case areaOfExpertise = "area_of_expertise"
        case bookingType = "booking_type"
        case startDate = "start_date"
        case endDate = "end_date"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

// MARK: - CustomerInfo
struct CustomerInfo: Codable {
    let name, gender, price: String
    let diseaseType: [String]

    enum CodingKeys: String, CodingKey {
        case name, gender, price
        case diseaseType = "disease_type"
    }
}
