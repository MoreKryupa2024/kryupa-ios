//
//  APIConstant.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import Foundation

struct APIConstants {
  static let success: String = "status"
  static let message: String = "message"
  static let userErrorMessage: String = "user_err_msg"
  static let blockedData: String = "data"
}

class APIConstant{
    
    static let baseURL = "https://ccjlmfh6-3050.inc1.devtunnels.ms"//Rubin
    
    static let googleSignup = "\(baseURL)/apis/auth/authenticate"
    static let uploadPDFFiles = "\(baseURL)/apis/user/file/multifileUpload"
    static let uploadProfile = "\(baseURL)/apis/user/file/uploadFile"
    static let careGiverCreateProfile = "\(baseURL)/apis/user/caregiver/create_profile"
    static let customerCreateProfile = "\(baseURL)/apis/user/customer/create_profile"
    static let getSlotList = "https://w7dvnjx5-3050.inc1.devtunnels.ms/apis/user/caregivers/lobby/slot_list"//CP
    static let bookSlot = "https://w7dvnjx5-3050.inc1.devtunnels.ms/apis/user/caregivers/lobby/book_slot"//CP
    static let lobbyStatus = "https://w7dvnjx5-3050.inc1.devtunnels.ms/apis/user/caregivers/lobby/lobby_status"//CP
    static let getRelativeList = "\(baseURL)/apis/booking/booking_for_dropdown"
    static let createBooking = "\(baseURL)/apis/booking/createBooking"
    static let getRecommandationList = "\(baseURL)/apis/user/home/getAllCustomerHomeData"
    static let findCareGiverBookingID = "\(baseURL)/apis/booking/find_caregiver"
    static let getCareGiverInCustomerDetails = "\(baseURL)/apis/user/getCaregiverById?id="
}

class FontContent{
    static let plusRegular = "PlusJakartaDisplay-Regular"
    static let plusLight = "PlusJakartaDisplay-Light"
    static let plusBold = "PlusJakartaDisplay-Bold"
    static let plusMedium = "PlusJakartaDisplay-Medium"
    
    static let besItalic = "Besley-Italic"
    static let besRegular = "Besley-Regular"
    static let besMedium = "Besley-Medium"
    static let besSemiBold = "Besley-SemiBold"
    static let besBold = "Besley-Bold"
}

class AppConstants{
    static let DeviceType = "IOS"
    
    static let SocialApple = "APPLE"
    static let SocialGoogle = "GOOGLE"

    static let SeekCare = "customer"
    static let GiveCare = "caregiver"
    
    static let medicalConditionArray = ["Diabetes","Hypertension","Heart Disease","Asthma","Arthritis","Osteoporosis","Chronic Kidney Disease","Depression","Obesity","None","Other"]
    static let needServiceInArray = ["Physical Therapy","Occupational Therapy","Nursing","Companianship"]
    static let genderArray = ["Male","Female","Other","Prefer not to say"]
    static let yearsOfExperienceArray = ["Any","3-4 Years","5-10 Years","10+ Years"]
    static let languageSpeakingArray = ["English","Spanish","French","Hindi","German","Russian","Korean","Arabic","Vietnamese","Tagalog","Cantonese and Mandarin",""]
    static let mobilityLevelArray = ["Full mobility","Moderate mobility","Limited mobility","Wheelchair-bound","Bedridden"]
    static let distanceArray = ["Within 1 mile","1-5 miles","5-10 miles"]
    static let relationArray = ["Spouse/Partner","Parent","Child","Sibling"]
    static let additionalSkillsAraay = ["Respite Care","Medical Transportation","Live in home care","Dementia","Transportation","Bathing/dressing","Errands/shopping","Companionship","Light housecleaning","Feeding","Meal preparation","Mobility Assistance","Help with staying physically active","Heavy lifting"]
   static let additionalInfoArray = ["Have a car","Non Smoker","Comfortable with pets","Covid Vaccinate"]

    
    static let timeZones = ["CEST": "Europe/Paris", "WEST": "Europe/Lisbon", "CDT": "America/Chicago", "EET": "Europe/Istanbul", "BRST": "America/Sao Paulo", "EEST": "Europe/Istanbul", "CET": "Europe/Paris", "MSD": "Europe/Moscow", "MST": "America/Denver", "KST": "Asia/Seoul", "PET": "America/Lima", "NZDT": "Pacific/Auckland", "CLT": "America/Santiago", "HST": "Pacific/Honolulu", "MDT": "America/Denver", "NZST": "Pacific/Auckland", "COT": "America/Bogota", "CST": "America/Chicago", "SGT": "Asia/Singapore", "CAT": "Africa/Harare", "BRT": "America/Sao Paulo", "WET": "Europe/Lisbon", "IST": "Asia/Calcutta", "HKT": "Asia/Hong Kong", "GST": "Asia/Dubai", "EDT": "America/New York", "WIT": "Asia/Jakarta", "UTC": "UTC", "JST": "Asia/Tokyo", "IRST": "Asia/Tehran", "PHT": "Asia/Manila", "AKDT": "America/Juneau", "BST": "Europe/London", "PST": "America/Los Angeles", "ART": "America/Argentina/Buenos Aires", "PDT": "America/Los Angeles", "WAT": "Africa/Lagos", "EST": "America/New York", "BDT": "Asia/Dhaka", "CLST": "America/Santiago", "AKST": "America/Juneau", "ADT": "America/Halifax", "AST": "America/Halifax", "PKT": "Asia/Karachi", "GMT": "GMT", "ICT": "Asia/Bangkok", "MSK": "Europe/Moscow", "EAT": "Africa/Addis Ababa"]

}
