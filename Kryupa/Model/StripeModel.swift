//
//  StripeModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 22/11/24.
//

import Foundation

// MARK: - Welcome
struct StripeClientSecretModel {
    let success: Bool
    let message: String
    let data: StripeClientSecretDataModel
    
    init(jsonData: [String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? false
        data = StripeClientSecretDataModel(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct StripeClientSecretDataModel {
//    let id, object: String
//    let application, automaticPaymentMethods, cancellationReason: String?
    let clientSecret: String
//    let created: Int
//    let customer, description, flowDirections, lastSetupError: String?
//    let latestAttempt: String?
//    let livemode: Bool
//    let mandate: String?
//    let nextAction, onBehalfOf, paymentMethod, paymentMethodConfigurationDetails: String?
//    let paymentMethodTypes: [String]
//    let singleUseMandate: String?
//    let status, usage: String

    init(jsonData: [String:Any]){
//        id = jsonData["id"] as? String ?? ""
//        object = jsonData["object"] as? String ?? ""
//        application = jsonData["application"] as? String ?? ""
//        automaticPaymentMethods = jsonData["automatic_payment_methods"] as? String ?? ""
//        cancellationReason = jsonData["cancellation_reason"] as? String ?? ""
        clientSecret = jsonData["client_secret"] as? String ?? ""
//        created = jsonData["created"] as? Int ?? 0
//        customer = jsonData["customer"] as? String ?? ""
//        description = jsonData["description"] as? String ?? ""
//        flowDirections = jsonData["flow_directions"] as? String ?? ""
//        lastSetupError = jsonData["last_setup_error"] as? String ?? ""
//        latestAttempt = jsonData["latest_attempt"] as? String ?? ""
//        livemode = jsonData["livemode"] as? Bool ?? false
//        mandate = jsonData["mandate"] as? String ?? ""
//        nextAction = jsonData["next_action"] as? String ?? ""
//        onBehalfOf = jsonData["on_behalf_of"] as? String ?? ""
//        paymentMethod = jsonData["payment_method"] as? String ?? ""
//        paymentMethodConfigurationDetails = jsonData["payment_method_configuration_details"] as? String ?? ""
//        paymentMethodTypes = jsonData["payment_method_types"] as? [String] ?? []
//        singleUseMandate = jsonData["single_use_mandate"] as? String ?? ""
//        status = jsonData["status"] as? String ?? ""
//        usage = jsonData["usage"] as? String ?? ""
    }
}



// MARK: - Welcome
struct StripeCustomerModel {
    let success: Bool
    let message: String
    let data: StripeCustomerDataModel
    
    init(jsonData: [String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? true
        data = StripeCustomerDataModel(jsonData: jsonData["data"] as? [String:Any] ?? [String:Any]())
    }
}

// MARK: - DataClass
struct StripeCustomerDataModel {
    let id, object: String
    let address: String?
    let balance, created: Int
    let currency, defaultSource: String?
    let delinquent: Bool
    let description, discount, email: String?
    let invoicePrefix: String
    let livemode: Bool
    let name: String?
    let nextInvoiceSequence: Int
    let phone: String?
    let preferredLocales: [String]
    let shipping: String?
    let taxExempt: String
    let testClock: String?

    init(jsonData: [String:Any]){
        id = jsonData["id"] as? String ?? ""
        object = jsonData["object"] as? String ?? ""
        address = jsonData["address"] as? String ?? ""
        balance = jsonData["balance"] as? Int ?? 0
        created = jsonData["created"] as? Int ?? 0
        currency = jsonData["currency"] as? String ?? ""
        defaultSource = jsonData["default_source"] as? String ?? ""
        delinquent = jsonData["delinquent"] as? Bool ?? false
        description = jsonData["description"] as? String ?? ""
        discount = jsonData["discount"] as? String ?? ""
        email = jsonData["email"] as? String ?? ""
        invoicePrefix = jsonData["invoice_prefix"] as? String ?? ""
        livemode = jsonData["livemode"] as? Bool ?? false
        name = jsonData["name"] as? String ?? ""
        nextInvoiceSequence = jsonData["next_invoice_sequence"] as? Int ?? 0
        phone = jsonData["phone"] as? String ?? ""
        preferredLocales = jsonData["preferred_locales"] as? [String] ?? []
        shipping = jsonData["shipping"] as? String ?? ""
        taxExempt = jsonData["tax_exempt"] as? String ?? ""
        testClock = jsonData["test_clock"] as? String ?? ""
    }
}



// MARK: - Welcome
struct StripeCardListModel {
    let data: [StripeCardListData]
    let message: String
    let success: Bool
    
    init(jsonData: [String:Any]){
        message = jsonData["message"] as? String ?? ""
        success = jsonData["success"] as? Bool ?? true
        data = (jsonData["data"] as? [[String:Any]] ?? [[String:Any]]()).map{StripeCardListData(jsonData: $0)}
    }
}

// MARK: - Datum
struct StripeCardListData {
    let id, userID: String
    let role: String
    let clientSecret: String
    let paymentmethodid: String
    let lastfour: String
    let stripecustomerid: String
    let isActive, isDeleted: Bool
    let updatedBy, createdBy: String?
    let createdAt, updatedAt: String

    init(jsonData: [String:Any]){
        id = jsonData["id"] as? String ?? ""
        userID = jsonData["user_id"] as? String ?? ""
        role = jsonData["role"] as? String ?? ""
        clientSecret = jsonData["client_secret"] as? String ?? ""
        paymentmethodid = jsonData["paymentmethodid"] as? String ?? ""
        lastfour = jsonData["lastfour"] as? String ?? ""
        stripecustomerid = jsonData["stripecustomerid"] as? String ?? ""
        isActive = jsonData["is_active"] as? Bool ?? true
        isDeleted = jsonData["is_deleted"] as? Bool ?? true
        updatedBy = jsonData["updated_by"] as? String ?? ""
        createdBy = jsonData["created_by"] as? String ?? ""
        createdAt = jsonData["created_at"] as? String ?? ""
        updatedAt = jsonData["updated_at"] as? String ?? ""
    }
}
