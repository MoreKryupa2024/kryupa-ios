//
//  BGVInterviewSlotsListModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 30/05/24.
//

import Foundation
// MARK: - Empty
struct BGVInterviewSlotsListModel {
    let success: Bool
    let data: [BGVInterviewSlotsListDataModel]
    
    init(jsonData:[String:Any]) {
        success = jsonData["success"] as? Bool ?? false
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{ BGVInterviewSlotsListDataModel(jsonData: $0)}
    }
}

// MARK: - Empty
struct BGVInterviewSlotStatusModel: Codable {
    let success: Bool
    let message: String
}

// MARK: - Datum
struct BGVInterviewSlotsListDataModel {
    let id, startingTime, endTime, availabilityDate: String

    init(jsonData:[String:Any]) {
        id = jsonData["id"] as? String ?? ""
        startingTime = jsonData["starting_time"] as? String ?? ""
        endTime = jsonData["end_time"] as? String ?? ""
        availabilityDate = jsonData["availability_date"] as? String ?? ""
    }
}

// MARK: - Empty
struct BGVInterviewSlotBookedStatusModel {
    let success: Bool
    let message: String
    let data: BGVInterviewBookedSlotData
    
    init(jsondata:[String:Any]) {
        message = jsondata["message"] as? String ?? ""
        success = jsondata["success"] as? Bool ?? false
        data = BGVInterviewBookedSlotData(jsonData: jsondata["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - Empty
struct BGVInterviewMeetingTokenModel {
    let success: Bool
    let message: String
    let data: BGVInterviewMeetingTokenData
    
    init(jsonData:[String:Any]) {
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = BGVInterviewMeetingTokenData(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct BGVInterviewMeetingTokenData {
    let sessionToken, sessionKey, topic, userIdentity: String

    init(jsonData:[String:Any]) {
        sessionToken = jsonData["sessionToken"] as? String ?? ""
        sessionKey = jsonData["session_key"] as? String ?? ""
        topic = jsonData["topic"] as? String ?? ""
        userIdentity = jsonData["userIdentity"] as? String ?? ""
    }
}


// MARK: - DataClass
struct BGVInterviewBookedSlotData {
    let bgvStatus, interviewStatus, ssnVerificationStatus, timeZone: String
    let interviewDateTime: String

    init(jsonData:[String:Any]){
        bgvStatus = jsonData["bgv_status"] as? String ?? ""
        interviewStatus = jsonData["interview_status"] as? String ?? ""
        ssnVerificationStatus = jsonData["ssn_verification_status"] as? String ?? ""
        timeZone = jsonData["time_zone"] as? String ?? ""
        interviewDateTime = jsonData["interview_date_time"] as? String ?? ""
    }
}
