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
    static let baseURLCP = "https://w7dvnjx5-3050.inc1.devtunnels.ms"//CP
    
    static let googleSignup = "\(baseURL)/apis/auth/authenticate"
    static let uploadPDFFiles = "\(baseURL)/apis/user/file/multifileUpload"
    static let uploadProfile = "\(baseURL)/apis/user/file/uploadFile"
    static let careGiverCreateProfile = "\(baseURL)/apis/user/caregiver/create_profile"
    static let customerCreateProfile = "\(baseURLCP)/apis/user/customer/create_profile"//-CP
    static let getSlotList = "\(baseURLCP)/apis/user/caregivers/lobby/slot_list"//CP
    static let bookSlot = "\(baseURLCP)/apis/user/caregivers/lobby/book_slot"//CP
    static let lobbyStatus = "\(baseURLCP)/apis/user/caregivers/lobby/lobby_status"//CP
    static let getRelativeList = "\(baseURL)/apis/booking/booking_for_dropdown"
    static let createBooking = "\(baseURL)/apis/booking/createBooking"
    static let getRecommandationList = "\(baseURL)/apis/user/home/getAllCustomerHomeData"
    static let findCareGiverBookingID = "\(baseURL)/apis/booking/find_caregiver"
    static let getCareGiverInCustomerDetails = "\(baseURL)/apis/user/getCaregiverById?id="
    static let getJobsNearYouList = "\(baseURL)/apis/user/home/getAllCaregiverHomeData"

    static let getUserStatus = "\(baseURL)/apis/user/CurrentStatus"
    static let sendRequestForBookCaregiver = "\(baseURL)/apis/booking/caregiver_approch"
    static let getProfile = "\(baseURLCP)/apis/user/customer/account/get_profile"//-CP
    static let profileList = "\(baseURLCP)/apis/user/customer/account/profile_list"//-CP
    static let createProfile = "\(baseURLCP)/apis/user/customer/account/create_profile"//-CP
    static let getPersonalDetails = "\(baseURLCP)/apis/user/customer/account/get_personal_details"//-CP
    static let updateProfile = "\(baseURLCP)/apis/user/customer/account/update_profile"//-CP
    static let deleteProfile = "\(baseURLCP)/apis/user/customer/account/delete_profile"//-CP
    static let updateProfilePicSeeker = "\(baseURLCP)/apis/user/customer/account/update_profile_pic"//-CP
    static let getBookings = "\(baseURL)/apis/booking/customerNavigation"
    static let getCareGiverBookings = "\(baseURL)/apis/booking/caregiverNavigation"
    static let getBookingDetailsById = "\(baseURL)/apis/booking/getBookingById?booking_id="
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
    
    static let medicalConditionArray = ["None","Diabetes","Hypertension","Heart Disease","Asthma","Arthritis","Osteoporosis","Chronic Kidney Disease","Depression","Obesity","Other"]
    static let needServiceInArray = ["Physical Therapy","Occupational Therapy","Nursing","Companianship"]
    static let genderArray = ["Male","Female","Other","Prefer not to say"]
    static let yearsOfExperienceArray = ["Any","3-4 Years","5-10 Years","10+ Years"]
    static let languageSpeakingArray = ["English","Spanish","French","Hindi","German","Russian","Korean","Arabic","Vietnamese","Tagalog","Cantonese and Mandarin",""]
    static let mobilityLevelArray = ["Full mobility","Moderate mobility","Limited mobility","Wheelchair-bound","Bedridden"]
    static let distanceArray = ["Within 1 mile","1-5 miles","5-10 miles"]
    static let relationArray = ["Spouse/Partner","Parent","Child","Sibling"]
    static let additionalSkillsAraay = ["Respite Care","Heavy lifting","Live in home care","Dementia","Transportation","Bathing/dressing","Errands/shopping","Companionship","Light housecleaning","Feeding","Meal preparation","Mobility Assistance","Help with staying physically active","Medical Transportation"]
   static let additionalInfoArray = ["Have a car","Non Smoker","Comfortable with pets","Covid Vaccinate"]
    
    static let giverAccountSectionItems = [
        AccountListData(title: "Personal Details", image: "personalDetail"),
        AccountListData(title: "My Services", image: "myservice"),
        AccountListData(title: "Payments", image: "payments"),
        AccountListData(title: "Reviews", image: "reviews"),
        AccountListData(title: "Help & FAQ", image: "help"),
        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout")
    ]

    static let seekerAccountSectionItems = [
        AccountListData(title: "Personal Details", image: "personalDetail"),
        AccountListData(title: "Payments & Refunds", image: "payments"),
        AccountListData(title: "Reviews", image: "reviews"),
        AccountListData(title: "Help & FAQ", image: "help"),
        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout")
    ]
    
    static let timeZones = ["CEST": "Europe/Paris", "WEST": "Europe/Lisbon", "CDT": "America/Chicago", "EET": "Europe/Istanbul", "BRST": "America/Sao Paulo", "EEST": "Europe/Istanbul", "CET": "Europe/Paris", "MSD": "Europe/Moscow", "MST": "America/Denver", "KST": "Asia/Seoul", "PET": "America/Lima", "NZDT": "Pacific/Auckland", "CLT": "America/Santiago", "HST": "Pacific/Honolulu", "MDT": "America/Denver", "NZST": "Pacific/Auckland", "COT": "America/Bogota", "CST": "America/Chicago", "SGT": "Asia/Singapore", "CAT": "Africa/Harare", "BRT": "America/Sao Paulo", "WET": "Europe/Lisbon", "IST": "Asia/Calcutta", "HKT": "Asia/Hong Kong", "GST": "Asia/Dubai", "EDT": "America/New York", "WIT": "Asia/Jakarta", "UTC": "UTC", "JST": "Asia/Tokyo", "IRST": "Asia/Tehran", "PHT": "Asia/Manila", "AKDT": "America/Juneau", "BST": "Europe/London", "PST": "America/Los Angeles", "ART": "America/Argentina/Buenos Aires", "PDT": "America/Los Angeles", "WAT": "Africa/Lagos", "EST": "America/New York", "BDT": "Asia/Dhaka", "CLST": "America/Santiago", "AKST": "America/Juneau", "ADT": "America/Halifax", "AST": "America/Halifax", "PKT": "Asia/Karachi", "GMT": "GMT", "ICT": "Asia/Bangkok", "MSK": "Europe/Moscow", "EAT": "Africa/Addis Ababa"]

}
