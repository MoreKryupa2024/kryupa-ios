//
//  CreateBookingModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import Foundation


// MARK: - Empty
struct BookingModel {
    let data: BookingData
    let success: Bool
    let message: String
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = BookingData(jsonData: (jsonData["data"] as? [String:Any] ?? [String:Any]()))
    }
}

// MARK: - DataClass
struct BookingData {
    let id : String
    init(jsonData:[String:Any]){
        id = jsonData["id"] as? String ?? ""
    }
}
