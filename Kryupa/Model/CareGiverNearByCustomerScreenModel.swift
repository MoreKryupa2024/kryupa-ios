//
//  CareGiverNearByCustomerScreenModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 05/06/24.
//

import Foundation

// MARK: - Empty
struct  CareGiverNearByCustomerScreenModel: Codable {
    let success: Bool
    let message: String
    let data: [CareGiverNearByCustomerScreenData]
}

// MARK: - Datum
struct  CareGiverNearByCustomerScreenData: Codable {
    let id, name, email: String
//    let zoomID: JSONNull?
    let isActive: Bool
    let providertype, role, status, fcmToken: String
//    let updatedBy, osType: JSONNull?
    let createdAt, updatedAt: String

}
