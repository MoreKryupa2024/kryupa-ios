//
//  BookingRecommendationModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import Foundation

// MARK: - Empty
struct BookingRecommendationModel: Codable {
    let data: BookingRecommendationData
    let message: String
    let success: Bool
}

// MARK: - DataClass
struct BookingRecommendationData: Codable {
    let recommendedCaregiver: [RecommendedCaregiver]
//    let upcommingAppointments, pastAppointments: [JSONAny]

}

// MARK: - RecommendedCaregiver
struct RecommendedCaregiver: Codable {
    let id, name, email: String
//    let zoomID: JSONNull?
    let isActive: Bool
    let providertype, role, status, fcmToken: String
//    let updatedBy, osType: JSONNull?
    let createdAt, updatedAt: String
    
    
}
