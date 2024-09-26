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
    
//    static let authBaseURL = "https://auth.wahinnovations.in"
    static let authBaseURL = "https://newapi.wahinnovations.in/apis/auth"
    
//    static let communicationBaseURL = "https://kmwswmkf-3050.inc1.devtunnels.ms/apis/communication"
//    static let communicationBaseURL = "https://communication.wahinnovations.in"
    static let communicationBaseURL = "https://newapi.wahinnovations.in/apis/communication"
    
//        static let paymentBaseURL = "https://kmwswmkf-3050.inc1.devtunnels.ms/apis/payment"
//    static let paymentBaseURL = "https://payments.wahinnovations.in"
    static let paymentBaseURL = "https://newapi.wahinnovations.in/apis/payment"
    
    
//    static let bookingBaseURL = "https://kmwswmkf-3050.inc1.devtunnels.ms/apis/booking"
//    static let bookingBaseURL = "https://booking.wahinnovations.in"
    static let bookingBaseURL = "https://newapi.wahinnovations.in/apis/booking"
    
//        static let userBaseURL = "https://kmwswmkf-3050.inc1.devtunnels.ms/apis/user"
//    static let userBaseURL = "https://user.wahinnovations.in"
    static let userBaseURL = "https://newapi.wahinnovations.in/apis/user"
    
//    static let adminBaseURL = "https://admin.wahinnovations.in"
    static let adminBaseURL = "https://newapi.wahinnovations.in/apis/admin"

    static let sendOTP = "\(authBaseURL)/send_otp"
    static let googleSignup = "\(authBaseURL)/authenticate"
    
    static let getAddress = "\(userBaseURL)/zp"
    static let caregiverSvcAct = "\(userBaseURL)/home/caregiverSvcAct"
    static let customerSvcAct = "\(userBaseURL)/home/customerSvcAct"
    static let updateNotification = "\(userBaseURL)/caregiver/update_notification"
    static let getNotification = "\(userBaseURL)/caregiver/get_notification"
    static let getUserStatus = "\(userBaseURL)/CurrentStatus"
    static let getProfile = "\(userBaseURL)/customer/account/get_profile"
    static let profileList = "\(userBaseURL)/customer/account/profile_list"
    static let createProfile = "\(userBaseURL)/customer/account/create_profile"
    static let getPersonalDetails = "\(userBaseURL)/customer/account/get_personal_details"
    static let updateProfile = "\(userBaseURL)/customer/account/update_profile"
    static let deleteProfile = "\(userBaseURL)/customer/account/delete_profile"
    static let updateProfilePicSeeker = "\(userBaseURL)/customer/account/update_profile_pic"
    static let reviewsSeeker = "\(userBaseURL)/customer/reviews/my_reviews"
    static let givenReviewsSeeker = "\(userBaseURL)/customer/reviews/given_reviews"
    static let viewReviewSeeker = "\(userBaseURL)/customer/reviews/view_review"
    static let updateProfilePicGiver = "\(userBaseURL)/caregiver/account/update_profile_pic"
    static let getProfileGiver = "\(userBaseURL)/caregiver/account/get_profile"
    static let personalDetailsGiver = "\(userBaseURL)/caregiver/account/personal_details"
    static let updateProfileGiver = "\(userBaseURL)/caregiver/account/update_profile"
    static let reviewsGiver = "\(userBaseURL)/caregiver/reviews/my_reviews"
    static let givenReviewsGiver = "\(userBaseURL)/caregiver/reviews/given_reviews"
    static let viewReviewGiver = "\(userBaseURL)/caregiver/reviews/view_review"
    static let verifyOTP = "\(userBaseURL)/caregiver/updateMobile"
    static let uploadPDFFiles = "\(userBaseURL)/file/multifileUpload"
    static let uploadProfile = "\(userBaseURL)/file/uploadFile"
    static let careGiverCreateProfile = "\(userBaseURL)/caregiver/create_profile"
    static let customerCreateProfile = "\(userBaseURL)/customer/create_profile"
    static let getSlotList = "\(userBaseURL)/caregivers/lobby/slot_list"
    static let lobbyStatus = "\(userBaseURL)/caregivers/lobby/lobby_status"
    static let getRecommandationList = "\(userBaseURL)/home/getAllCustomerHomeData"
    static let getCareGiverInCustomerDetails = "\(userBaseURL)/getCaregiverById?id="
    static let getJobsNearYouList = "\(userBaseURL)/home/getAllCaregiverHomeData"
    static let deleteAccount = "\(userBaseURL)/account/delete"
    static let addReview = "\(userBaseURL)/customer/reviews/add_review"
    static let bookingReviews = "\(userBaseURL)/customer/reviews/booking_reviews"
    static let addReviewGiver = "\(userBaseURL)/caregiver/reviews/add_review"
    static let bookingReviewsGiver = "\(userBaseURL)/caregiver/reviews/booking_reviews"
    static let myServices = "\(userBaseURL)/caregiver/account/my_services"
    static let updateMyService = "\(userBaseURL)/caregiver/account/Update_my_service"

    static let getRelativeList = "\(bookingBaseURL)/booking_for_dropdown"
    static let createBooking = "\(bookingBaseURL)/createBooking"
    static let findCareGiverBookingID = "\(bookingBaseURL)/find_caregiver"
    static let getJobList = "\(bookingBaseURL)/job_list"
    static let getCustomerRequirements = "\(bookingBaseURL)/get_customer_requirements"
    static let getBookings = "\(bookingBaseURL)/customerNavigation"
    static let getCareGiverBookings = "\(bookingBaseURL)/caregiverNavigation"
    static let getBookingDetailsById = "\(bookingBaseURL)/getBookingById?booking_id="
    static let updateApprochStatus = "\(bookingBaseURL)/update_approch_status"
    static let bookingDetailsForCaregiver = "\(bookingBaseURL)/BookingDetailsForCaregiver"
    static let sendRequestForBookCaregiver = "\(bookingBaseURL)/caregiver_approch"
    static let giverConfirmStartService = "\(bookingBaseURL)/confirm-booking"
    static let customerConfirmStartService = "\(bookingBaseURL)/confirm-booking-customer"
    static let cancelBookingData = "\(bookingBaseURL)/booking_status"
    static let bookingCancel = "\(bookingBaseURL)/booking_cancel"
    
    static let getPaypalOrderID = "\(paymentBaseURL)/paypal/create_order_for_wallet"
    static let confirmPaypalOrderID = "\(paymentBaseURL)/paypal/capture_order"
    static let getAllTransaction = "\(paymentBaseURL)/transaction/get_all_transaction"
    static let getWalletById = "\(paymentBaseURL)/wallet/getWalletById"
    static let payCaregiverBooking = "\(paymentBaseURL)/wallet/pay_for_caregiver_booking"
    static let getBankList = "\(paymentBaseURL)/bank/get_bank_list"
    static let addBank = "\(paymentBaseURL)/bank/add_bank"
    static let getOrderInvoice = "\(paymentBaseURL)/paypal/order_invoice"
    static let OrderList = "\(paymentBaseURL)/payment_history/Order_list"
    
    
    static let getMeetingToken = "\(communicationBaseURL)/meeting/zoom_session_token"
    static let getChatHistory = "\(communicationBaseURL)/chat/get_conversation"
    static let createConversation = "\(communicationBaseURL)/chat/create_conversation"
    static let getInboxList = "\(communicationBaseURL)/chat/contact_list"
    static let bookSlot = "\(communicationBaseURL)/meeting/book_slot"
    static let conversationWithAdmin = "\(communicationBaseURL)/chat/conversationWithAdmin"
    static let chatVideoCall = "\(communicationBaseURL)/vido_call/start"
    static let chatVideoCallRecieve = "\(communicationBaseURL)/vido_call/recieve"
    
    static let getBannerUrls = "\(adminBaseURL)/get_banner_urls"
    static let deletebooking = "\(bookingBaseURL)/deletebooking"
    
    static let logout = "\(authBaseURL)/authenticate/logout"
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
    static let lobbyScreenBanner = "Lobby"
    static let REFFERANDEARNScreenBanner = "Reffer and Earn"
    static let CAREGIVERHOMETOPScreenBanner = "Caregiver Home Top"
    static let CAREGIVERHOMEBOTTOMScreenBanner = "Caregiver Home Bottom"
    static let CUSTOMERHOMETOPScreenBanner = "Customer Home Top"
    static let CUSTOMERHOMEBOTTOMScreenBanner = "Customer Home Bottom"
    
    static let config = CoreConfig(clientID: "Acsfr2dcilBLBuXe5FYHkJ68qi2w8JXQMPlWuD-qNjMVrTUPIOYPutpHRquOPZ_rv67J1YgAkDOQ8zP4", environment: .sandbox)
    static let DeviceType = "IOS"
    
    static let SocialApple = "APPLE"
    static let SocialGoogle = "GOOGLE"

    static let SeekCare = "customer"
    static let GiveCare = "caregiver"
    
    static let VideoCall = "Video Call"
    static let Chat = "Chat"
    static let AudioCall = "Audio Call"
    static let canHelpInArray = ["Bathing", "Dressing", "Eating/cutting up food", "Toileting", "Walking/Transferring",]
    
    static let medicalConditionArray = ["Arthritis","Asthma","Chronic Kidney Disease","Depression","Diabetes","Heart Disease","Hypertension","Obesity","Osteoporosis","Obesity","Other","None"]
    static let cancelSeekerReasons = ["Change in Schedule","Service No Longer Needed","Personal Reasons","Misunderstanding with Caregiver","Other"]
    
    static let cancelGiverReasons = ["Personal Reasons","Health Issues","Miscommunication/Disagreement","Unable to Meet Care Requirements","Other"]
    static let needServiceInArray = ["Nursing","Physical Therapy","Occupational Therapy","Support Services(Companionship, Housekeeping, Home Health Aid)"]
    static let genderArray = ["Male","Female","Other","Prefer not to say"]
    static let mobArray = ["Independent","Need Assistance"]
    static let yearsOfExperienceArray = ["Any","1-2 Years","3-4 Years","5-10 Years","10+ Years"]
    static let languageSpeakingArray = ["German","Spanish","French","Hindi","Mandarin","Russian","Tagalog","Vietnamese","English",""]
    static let mobilityLevelArray = ["Full mobility","Moderate mobility","Limited mobility","Wheelchair-bound","Bedridden","No Preference"]
    static let distanceArray = ["Within 1 mile","Within 5 mile","Within 10 mile","Within 15 mile","Within 20 mile"]
    static let relationArray = ["Child","Friend","Parent","Sibling","Spouse"]
    static let additionalSkillsAraay = ["Respite Care","Heavy lifting","Live in home care","Dementia","Transportation","Bathing/dressing","Errands/shopping","Companionship","Light housecleaning","Feeding","Meal preparation","Mobility Assistance","Help with staying physically active","Medical Transportation"]
   static let additionalInfoArray = ["Have a car","Non Smoker","Comfortable with pets","Covid Vaccinate"]
    
    static let giverAccountSectionItems = [
        AccountListData(title: "Personal Details & Preferences", image: "personalDetail"),
        AccountListData(title: "My Services", image: "myservice"),
        AccountListData(title: "Payments", image: "payments"),
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
        AccountListData(title: "Wallet", image: "wallet"),
        AccountListData(title: "Reviews", image: "reviews"),
        AccountListData(title: "Help & FAQ", image: "help"),
//        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout"),
        AccountListData(title: "Deactivate account", image: "setting_delete_account")
    ]
    
    static let timeZones = ["CEST": "Europe/Paris", "WEST": "Europe/Lisbon", "CDT": "America/Chicago", "EET": "Europe/Istanbul", "BRST": "America/Sao Paulo", "EEST": "Europe/Istanbul", "CET": "Europe/Paris", "MSD": "Europe/Moscow", "MST": "America/Denver", "KST": "Asia/Seoul", "PET": "America/Lima", "NZDT": "Pacific/Auckland", "CLT": "America/Santiago", "HST": "Pacific/Honolulu", "MDT": "America/Denver", "NZST": "Pacific/Auckland", "COT": "America/Bogota", "CST": "America/Chicago", "SGT": "Asia/Singapore", "CAT": "Africa/Harare", "BRT": "America/Sao Paulo", "WET": "Europe/Lisbon", "IST": "Asia/Calcutta", "HKT": "Asia/Hong Kong", "GST": "Asia/Dubai", "EDT": "America/New York", "WIT": "Asia/Jakarta", "UTC": "UTC", "JST": "Asia/Tokyo", "IRST": "Asia/Tehran", "PHT": "Asia/Manila", "AKDT": "America/Juneau", "BST": "Europe/London", "PST": "America/Los Angeles", "ART": "America/Argentina/Buenos Aires", "PDT": "America/Los Angeles", "WAT": "Africa/Lagos", "EST": "America/New York", "BDT": "Asia/Dhaka", "CLST": "America/Santiago", "AKST": "America/Juneau", "ADT": "America/Halifax", "AST": "America/Halifax", "PKT": "Asia/Karachi", "GMT": "GMT", "ICT": "Asia/Bangkok", "MSK": "Europe/Moscow", "EAT": "Africa/Addis Ababa"]
}
