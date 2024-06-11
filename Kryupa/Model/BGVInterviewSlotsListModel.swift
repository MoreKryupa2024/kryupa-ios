//
//  BGVInterviewSlotsListModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 30/05/24.
//

import Foundation
// MARK: - Empty
struct BGVInterviewSlotsListModel: Codable {
    let success: Bool
    let data: [BGVInterviewSlotsListDataModel]
}

// MARK: - Empty
struct BGVInterviewSlotStatusModel: Codable {
    let success: Bool
    let message: String
}

// MARK: - Datum
struct BGVInterviewSlotsListDataModel: Codable {
    let id, startingTime, endTime, availabilityDate, timezone: String
    
}
