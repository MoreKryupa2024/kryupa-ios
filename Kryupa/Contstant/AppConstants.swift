//
//  AppConstants.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 11/11/24.
//

import Foundation
import CorePayments

class AppConstants{
    static let lobbyScreenBanner = "Lobby"
    static let REFFERANDEARNScreenBanner = "Reffer and Earn"
    static let CAREGIVERHOMETOPScreenBanner = "Caregiver Home Top"
    static let CAREGIVERHOMEBOTTOMScreenBanner = "Caregiver Home Bottom"
    static let CUSTOMERHOMETOPScreenBanner = "Customer Home Top"
    static let CUSTOMERHOMEBOTTOMScreenBanner = "Customer Home Bottom"
    
    static let config = CoreConfig(clientID: "Acsfr2dcilBLBuXe5FYHkJ68qi2w8JXQMPlWuD-qNjMVrTUPIOYPutpHRquOPZ_rv67J1YgAkDOQ8zP4", environment: .sandbox)
    static let DeviceType = "IOS"
    static let platformFee = 2
    
    static let SocialApple = "APPLE"
    static let SocialGoogle = "GOOGLE"

    static let SeekCare = "customer"
    static let GiveCare = "caregiver"
    
    static let VideoCall = "Video Call"
    static let Chat = "Chat"
    static let AudioCall = "Audio Call"
    static let canHelpInArray = ["Bathing", "Dressing", "Eating", "Toileting", "Walking/Transferring",]
    
    static let medicalConditionArray = ["None","Arthritis","Asthma","Chronic Kidney Disease","Depression","Diabetes","Heart Disease","Hypertension","Obesity","Osteoporosis","Other"]
    static let cancelSeekerReasons = ["Change in Schedule","Service No Longer Needed","Personal Reasons","Misunderstanding with Caregiver","Other"]
    
    static let cancelGiverReasons = ["Personal Reasons","Health Issues","Miscommunication/Disagreement","Unable to Meet Care Requirements","Other"]
    static let needServiceInArray = ["Nursing","Physical Therapy","Occupational Therapy","Support Services(Companionship, Housekeeping, Home Health Aid)"]
    static let genderArray = ["Male","Female","Prefer not to say"]
    static let bankAccountType = ["Standard","Individual"]
    static let mobArray = ["Independent","Need Assistance"]
    static let yearsOfExperienceArray = ["Any","1-2 Years","3-4 Years","5-10 Years","10+ Years"]
    static let languageSpeakingArray = ["English","French","German","Hindi","Mandarin","Russian","Spanish","Tagalog","Vietnamese",""]
    static let mobilityLevelArray = ["Full mobility","Moderate mobility","Limited mobility","Wheelchair-bound","Bedridden","No Preference"]
    static let distanceArray = ["Within 1 mile","Within 5 mile","Within 10 mile","Within 15 mile","Within 20 mile"]
    static let relationArray = ["Child","Friend","Parent","Sibling","Spouse", "Other"]
    static let additionalSkillsAraay = ["Respite Care","Heavy lifting","Live in home care","Dementia","Transportation","Bathing/dressing","Errands/shopping","Companionship","Light housecleaning","Feeding","Meal preparation","Mobility Assistance","Help with staying physically active","Medical Transportation"]
   static let additionalInfoArray = ["Have a car","Non Smoker","Comfortable with pets","Covid Vaccinated"]
    
    static let giverAccountSectionItems = [
        AccountListData(title: "Personal Details & Preferences", image: "personalDetail"),
        AccountListData(title: "My Services", image: "myservice"),
        AccountListData(title: "Payments", image: "payments"),
        AccountListData(title: "Kryupa Cash", image: "wallet"),
        AccountListData(title: "Reviews", image: "reviews"),
        AccountListData(title: "Help & FAQ", image: "help"),
//        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout"),
        AccountListData(title: "Deactivate account", image: "setting_delete_account")
    ]

    static let seekerAccountSectionItems = [
        AccountListData(title: "Personal Details", image: "personalDetail"),
        AccountListData(title: "Payments", image: "payments"),
        AccountListData(title: "Kryupa Cash", image: "wallet"),
        AccountListData(title: "Reviews", image: "reviewsSeeker"),
        AccountListData(title: "Help & FAQ", image: "help"),
//        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout"),
        AccountListData(title: "Deactivate account", image: "setting_delete_account")
    ]
    
    static let timeZones = ["CEST": "Europe/Paris", "WEST": "Europe/Lisbon", "CDT": "America/Chicago", "EET": "Europe/Istanbul", "BRST": "America/Sao Paulo", "EEST": "Europe/Istanbul", "CET": "Europe/Paris", "MSD": "Europe/Moscow", "MST": "America/Denver", "KST": "Asia/Seoul", "PET": "America/Lima", "NZDT": "Pacific/Auckland", "CLT": "America/Santiago", "HST": "Pacific/Honolulu", "MDT": "America/Denver", "NZST": "Pacific/Auckland", "COT": "America/Bogota", "CST": "America/Chicago", "SGT": "Asia/Singapore", "CAT": "Africa/Harare", "BRT": "America/Sao Paulo", "WET": "Europe/Lisbon", "IST": "Asia/Calcutta", "HKT": "Asia/Hong Kong", "GST": "Asia/Dubai", "EDT": "America/New York", "WIT": "Asia/Jakarta", "UTC": "UTC", "JST": "Asia/Tokyo", "IRST": "Asia/Tehran", "PHT": "Asia/Manila", "AKDT": "America/Juneau", "BST": "Europe/London", "PST": "America/Los Angeles", "ART": "America/Argentina/Buenos Aires", "PDT": "America/Los Angeles", "WAT": "Africa/Lagos", "EST": "America/New York", "BDT": "Asia/Dhaka", "CLST": "America/Santiago", "AKST": "America/Juneau", "ADT": "America/Halifax", "AST": "America/Halifax", "PKT": "Asia/Karachi", "GMT": "GMT", "ICT": "Asia/Bangkok", "MSK": "Europe/Moscow", "EAT": "Africa/Addis Ababa"]
}
