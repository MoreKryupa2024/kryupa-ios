//
//  CreateBookingModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 04/06/24.
//

import Foundation


// MARK: - Empty
struct BookingModel: Codable {
    let data: BookingData
    let success: Bool
    let message: String
}

// MARK: - DataClass
struct BookingData: Codable {
    let id : String
//    let startDate, endDate, startTime, endTime: String
//    let gender, updatedBy: String
//    let isActive, isDeleted: Bool
//    let createdAt, updatedAt: String
    
    
}
