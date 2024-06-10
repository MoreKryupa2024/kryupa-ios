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

// MARK: - Datum
struct BGVInterviewSlotsListDataModel: Codable,Identifiable {
    let id, startingTime, endTime, avabilityDate, timeZone: String
    
}
