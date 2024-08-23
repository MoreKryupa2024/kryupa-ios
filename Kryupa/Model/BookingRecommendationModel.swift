//
//  BookingRecommendationModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import Foundation

// MARK: - Empty
struct BookingRecommendationModel {
    let data: CustomerHomeData
    let message: String
    let success: Bool
    
    init(jsonData:[String:Any]) {
        self.data = CustomerHomeData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
        self.message = jsonData["message"] as? String ?? ""
        self.success = jsonData["success"] as? Bool ?? false
    }
}

// MARK: - DataClass
struct CustomerHomeData {
    let recommendedCaregiver: [RecommendedCaregiverData]
    let upcommingAppointments, pastAppointments: [BookingsListData]

    init(jsonData:[String:Any]) {
        self.recommendedCaregiver = (jsonData["recommended_caregiver"] as? [[String:Any]] ?? [[String:Any]]()).map{RecommendedCaregiverData(jsonData: $0)}
        self.upcommingAppointments = (jsonData["upcomming_appointments"] as? [[String:Any]] ?? [[String:Any]]()).map{BookingsListData(jsonData: $0)}
        self.pastAppointments = (jsonData["past_appointments"] as? [[String:Any]] ?? [[String:Any]]()).map{BookingsListData(jsonData: $0)}
    }
}

// MARK: - Appointment
//struct AppointmentData {
//    let id, caregiverID, startDate, endDate,customerID: String
//    let startTime, endTime, bookingID, status: String
//    let name: String
//    let profilePictureURL: String
//    let relation: String
//    let price: Double
//    let arrayAgg: [String]
//
//    init(jsonData:[String:Any]) {
//        id = jsonData["id"] as? String ?? ""
//        caregiverID = jsonData["caregiver_id"] as? String ?? ""
//        customerID = jsonData["customer_id"] as? String ?? ""
//        startDate = jsonData["start_date"] as? String ?? ""
//        endDate = jsonData["end_date"] as? String ?? ""
//        startTime = jsonData["start_time"] as? String ?? ""
//        endTime = jsonData["end_time"] as? String ?? ""
//        bookingID = jsonData["booking_id"] as? String ?? ""
//        status = jsonData["status"] as? String ?? ""
//        name = jsonData["name"] as? String ?? ""
//        profilePictureURL = jsonData["profile_picture_url"] as? String ?? ""
//        relation = jsonData["relation"] as? String ?? ""
//        price = jsonData["price"] as? Double ?? 0.0
//        arrayAgg = jsonData["array_agg"] as? [String] ?? []
//    }
//}

// MARK: - RecommendedCaregiver
struct RecommendedCaregiverData {
    let id, name, rating, reviewCount: String
    let profileURL: String
    let pricePerHour, yearOfExprience: Double
    let arrayAgg: [String]

    init(jsonData:[String:Any]) {
        id = jsonData["id"] as? String ?? ""
        name = jsonData["name"] as? String ?? ""
        rating = jsonData["rating"] as? String ?? ""
        reviewCount = jsonData["review_count"] as? String ?? ""
        profileURL = jsonData["profile_url"] as? String ?? ""
        arrayAgg = jsonData["array_agg"] as? [String] ?? []
        yearOfExprience = jsonData["year_of_exprience"] as? Double ?? Double(jsonData["year_of_exprience"] as? Int ?? Int(jsonData["year_of_exprience"] as? String ?? "") ?? 0 )
        pricePerHour = jsonData["price_per_hour"] as? Double ?? Double(jsonData["price_per_hour"] as? Int ?? Int(jsonData["price_per_hour"] as? String ?? "") ?? 0 )
    }
}
