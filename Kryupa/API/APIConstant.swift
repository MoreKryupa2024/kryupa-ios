//
//  APIConstant.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import Foundation
import CorePayments

struct APIConstants {
  static let success: String = "status"
  static let message: String = "message"
  static let userErrorMessage: String = "user_err_msg"
  static let blockedData: String = "data"
}

class APIConstant{
    
    static let baseURL = "https://ccjlmfh6-3050.inc1.devtunnels.ms"//Rubin
//    static let baseURL = "https://w7dvnjx5-3050.inc1.devtunnels.ms"//CP

    
    static let sendOTP = "\(baseURL)/apis/auth/send_otp"
    static let googleSignup = "\(baseURL)/apis/auth/authenticate"
    
    
    static let caregiverSvcAct = "\(baseURL)/apis/user/home/caregiverSvcAct"
    static let customerSvcAct = "\(baseURL)/apis/user/home/customerSvcAct"
    static let updateNotification = "\(baseURL)/apis/user/caregiver/update_notification"
    static let getNotification = "\(baseURL)/apis/user/caregiver/get_notification"
    static let getUserStatus = "\(baseURL)/apis/user/CurrentStatus"
    static let getProfile = "\(baseURL)/apis/user/customer/account/get_profile"//-CP
    static let profileList = "\(baseURL)/apis/user/customer/account/profile_list"//-CP
    static let createProfile = "\(baseURL)/apis/user/customer/account/create_profile"//-CP
    static let getPersonalDetails = "\(baseURL)/apis/user/customer/account/get_personal_details"//-CP
    static let updateProfile = "\(baseURL)/apis/user/customer/account/update_profile"//-CP
    static let deleteProfile = "\(baseURL)/apis/user/customer/account/delete_profile"//-CP
    static let updateProfilePicSeeker = "\(baseURL)/apis/user/customer/account/update_profile_pic"//-CP
    static let reviewsSeeker = "\(baseURL)/apis/user/customer/reviews/my_reviews"
    static let givenReviewsSeeker = "\(baseURL)/apis/user/customer/reviews/given_reviews"
    static let viewReviewSeeker = "\(baseURL)/apis/user/customer/reviews/view_review"
    static let updateProfilePicGiver = "\(baseURL)/apis/user/caregiver/account/update_profile_pic"
    static let getProfileGiver = "\(baseURL)/apis/user/caregiver/account/get_profile"
    static let personalDetailsGiver = "\(baseURL)/apis/user/caregiver/account/personal_details"
    static let updateProfileGiver = "\(baseURL)/apis/user/caregiver/account/update_profile"
    static let reviewsGiver = "\(baseURL)/apis/user/caregiver/reviews/my_reviews"
    static let givenReviewsGiver = "\(baseURL)/apis/user/caregiver/reviews/given_reviews"
    static let viewReviewGiver = "\(baseURL)/apis/user/caregiver/reviews/view_review"
    static let verifyOTP = "\(baseURL)/apis/user/caregiver/updateMobile"
    static let uploadPDFFiles = "\(baseURL)/apis/user/file/multifileUpload"
    static let uploadProfile = "\(baseURL)/apis/user/file/uploadFile"
    static let careGiverCreateProfile = "\(baseURL)/apis/user/caregiver/create_profile"
    static let customerCreateProfile = "\(baseURL)/apis/user/customer/create_profile"//-CP
    static let getSlotList = "\(baseURL)/apis/user/caregivers/lobby/slot_list"//CP
    static let lobbyStatus = "\(baseURL)/apis/user/caregivers/lobby/lobby_status"//CP
    static let getRecommandationList = "\(baseURL)/apis/user/home/getAllCustomerHomeData"
    static let getCareGiverInCustomerDetails = "\(baseURL)/apis/user/getCaregiverById?id="
    static let getJobsNearYouList = "\(baseURL)/apis/user/home/getAllCaregiverHomeData"
    static let deleteAccount = "\(baseURL)/apis/user/account/delete"
    static let addReview = "\(baseURL)/apis/user/customer/reviews/add_review"
    static let bookingReviews = "\(baseURL)/apis/user/customer/reviews/booking_reviews"
    static let addReviewGiver = "\(baseURL)/apis/user/caregiver/reviews/add_review"
    static let bookingReviewsGiver = "\(baseURL)/apis/user/caregiver/reviews/booking_reviews"
    
    
    static let getRelativeList = "\(baseURL)/apis/booking/booking_for_dropdown"
    static let createBooking = "\(baseURL)/apis/booking/createBooking"
    static let findCareGiverBookingID = "\(baseURL)/apis/booking/find_caregiver"
    static let getJobList = "\(baseURL)/apis/booking/job_list"
    static let getCustomerRequirements = "\(baseURL)/apis/booking/get_customer_requirements"
    static let getBookings = "\(baseURL)/apis/booking/customerNavigation"
    static let getCareGiverBookings = "\(baseURL)/apis/booking/caregiverNavigation"
    static let getBookingDetailsById = "\(baseURL)/apis/booking/getBookingById?booking_id="
    static let updateApprochStatus = "\(baseURL)/apis/booking/update_approch_status"
    static let bookingDetailsForCaregiver = "\(baseURL)/apis/booking/BookingDetailsForCaregiver"
    static let sendRequestForBookCaregiver = "\(baseURL)/apis/booking/caregiver_approch"
    static let giverConfirmStartService = "\(baseURL)/apis/booking/confirm-booking"
    static let customerConfirmStartService = "\(baseURL)/apis/booking/confirm-booking-customer"
    
    
    static let getPaypalOrderID = "\(baseURL)/apis/payment/paypal/create_order_for_wallet"
    static let confirmPaypalOrderID = "\(baseURL)/apis/payment/paypal/capture_order"
    static let getAllTransaction = "\(baseURL)/apis/payment/transaction/get_all_transaction"
    static let getWalletById = "\(baseURL)/apis/payment/wallet/getWalletById"
    static let payCaregiverBooking = "\(baseURL)/apis/payment/wallet/pay_for_caregiver_booking"
    static let getBankList = "\(baseURL)/apis/payment/bank/get_bank_list"
    static let addBank = "\(baseURL)/apis/payment/bank/add_bank"
    static let getOrderInvoice = "\(baseURL)/apis/payment/paypal/order_invoice"
    
    
    static let getMeetingToken = "\(baseURL)/apis/communication/meeting/zoom_session_token"
    static let getChatHistory = "\(baseURL)/apis/communication/chat/get_conversation"
    static let createConversation = "\(baseURL)/apis/communication/chat/create_conversation"
    static let getInboxList = "\(baseURL)/apis/communication/chat/contact_list"
    static let bookSlot = "\(baseURL)/apis/communication/meeting/book_slot"
    static let conversationWithAdmin = "\(baseURL)/apis/communication/chat/conversationWithAdmin"
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
    static let config = CoreConfig(clientID: "Acsfr2dcilBLBuXe5FYHkJ68qi2w8JXQMPlWuD-qNjMVrTUPIOYPutpHRquOPZ_rv67J1YgAkDOQ8zP4", environment: .sandbox)
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
        AccountListData(title: "Wallet", image: "wallet"),
        AccountListData(title: "Reviews", image: "reviews"),
        AccountListData(title: "Help & FAQ", image: "help"),
        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout")
    ]
    
    static let timeZones = ["CEST": "Europe/Paris", "WEST": "Europe/Lisbon", "CDT": "America/Chicago", "EET": "Europe/Istanbul", "BRST": "America/Sao Paulo", "EEST": "Europe/Istanbul", "CET": "Europe/Paris", "MSD": "Europe/Moscow", "MST": "America/Denver", "KST": "Asia/Seoul", "PET": "America/Lima", "NZDT": "Pacific/Auckland", "CLT": "America/Santiago", "HST": "Pacific/Honolulu", "MDT": "America/Denver", "NZST": "Pacific/Auckland", "COT": "America/Bogota", "CST": "America/Chicago", "SGT": "Asia/Singapore", "CAT": "Africa/Harare", "BRT": "America/Sao Paulo", "WET": "Europe/Lisbon", "IST": "Asia/Calcutta", "HKT": "Asia/Hong Kong", "GST": "Asia/Dubai", "EDT": "America/New York", "WIT": "Asia/Jakarta", "UTC": "UTC", "JST": "Asia/Tokyo", "IRST": "Asia/Tehran", "PHT": "Asia/Manila", "AKDT": "America/Juneau", "BST": "Europe/London", "PST": "America/Los Angeles", "ART": "America/Argentina/Buenos Aires", "PDT": "America/Los Angeles", "WAT": "Africa/Lagos", "EST": "America/New York", "BDT": "Asia/Dhaka", "CLST": "America/Santiago", "AKST": "America/Juneau", "ADT": "America/Halifax", "AST": "America/Halifax", "PKT": "Asia/Karachi", "GMT": "GMT", "ICT": "Asia/Bangkok", "MSK": "Europe/Moscow", "EAT": "Africa/Addis Ababa"]
}
