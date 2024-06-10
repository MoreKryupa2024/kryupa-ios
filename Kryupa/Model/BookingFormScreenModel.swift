//
//  BookingFormScreenModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 31/05/24.
//

import Foundation


// MARK: - Empty
struct RelativeModel: Codable {
    let success: Bool
    let message: String
    let data: [RelativeDataModel]
}

// MARK: - Datum
struct RelativeDataModel: Codable {
    let id, name: String
}
