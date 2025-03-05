//
//  ApplePayResponseModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 18/11/24.
//

import Foundation

struct ApplePayModel {
    let success: Bool
    let message: String
    
    init(jsonData:[String:Any]){
        success = jsonData["success"] as? Bool ?? true
        message = jsonData["message"] as? String ?? ""
    }
}

struct CardVerificationModel {
    let status: Bool
    let message: String
    let data: [String]
    
    init(jsonData:[String:Any]){
        status = jsonData["status"] as? Bool ?? false
        message = jsonData["message"] as? String ?? ""
        data = jsonData["data"] as? [String] ?? []
    }
}
