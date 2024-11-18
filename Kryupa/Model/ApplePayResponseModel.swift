//
//  ApplePayResponseModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 14/11/24.
//

import Foundation

struct ApplePayModel: Codable {
    let success: Bool
    let message: String
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? true
        message = jsonData["message"] as? String ?? ""
    }
}

struct CardVerificationModel: Codable {
    let status: Bool
    let message: String
    let data: [String]
    
    init(jsonData:[String:Any]){
        status = jsonData["status"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = jsonData["data"] as? [String] ?? []
    }

}
