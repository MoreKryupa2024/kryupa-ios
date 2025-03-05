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
    
    //MARK: Base URL's
    static let stagingbaseURL = "https://staging.wahinnovations.in"//
    static let baseURL = "https://newapi.wahinnovations.in"
    
    //MARK: Server URL's Strat
    static let authBaseURL = "\(stagingbaseURL)/apis/auth"
    
    static let communicationBaseURL = "\(stagingbaseURL)/apis/communication"
    
    static let chatURL = "\(stagingbaseURL)/"
    
    static let paymentBaseURL = "\(stagingbaseURL)/apis/payment"
    
    static let bookingBaseURL = "\(stagingbaseURL)/apis/booking"
    
    static let userBaseURL = "\(stagingbaseURL)/apis/user"
    
    static let adminBaseURL = "\(stagingbaseURL)/apis/admin"
    //MARK: Server URL's End
    
    
    //MARK: Auth API's
    static let sendOTP = "\(authBaseURL)/send_otp"
    static let googleSignup = "\(authBaseURL)/authenticate"
    static let activateAccount = "\(authBaseURL)/authenticate/activate"
    
    //MARK: User API's
    static let profileUpdate = "\(userBaseURL)/customer/profile/add_profile"
    static let getAddress = "\(userBaseURL)/zp"
    static let caregiverSvcAct = "\(userBaseURL)/home/caregiverSvcAct"
    static let customerSvcAct = "\(userBaseURL)/home/customerSvcAct"
    static let updateNotification = "\(userBaseURL)/caregiver/update_notification"
    static let getNotification = "\(userBaseURL)/caregiver/get_notification"
    static let getUserStatus = "\(userBaseURL)/CurrentStatus"
    static let getProfile = "\(userBaseURL)/customer/account/get_profile"
    static let profileList = "\(userBaseURL)/customer/account/profile_list"
    static let createProfile = "\(userBaseURL)/customer/account/create_profile"
    static let getPersonalDetails = "\(userBaseURL)/customer/profile/id_opration"
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
    static let deactivateAccount = "\(userBaseURL)/account/deactivate"

    
    //MARK: Booking API's
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
    static let bookingDetailsForCustomer = "\(bookingBaseURL)/BookingDetailsForCustomer"
    static let createDraftBooking = "\(bookingBaseURL)/draft/create"
    static let getDraftList = "\(bookingBaseURL)/draft/get"
    static let getDraftDetails = "\(bookingBaseURL)/draft/getbyid"
    static let sendRequestForBookCaregiver = "\(bookingBaseURL)/caregiver_approch"
    static let giverConfirmStartService = "\(bookingBaseURL)/confirm-booking"
    static let cancelStartService = "\(bookingBaseURL)/cancel/caregiverservice"
    static let customerConfirmStartService = "\(bookingBaseURL)/confirm-booking-customer"
    static let cancelBookingData = "\(bookingBaseURL)/booking_status"
    static let bookingCancel = "\(bookingBaseURL)/booking_cancel"
    static let getCardVerificationInfo = "\(bookingBaseURL)/appleinfo/get"
    static let setCardVerificationInfo = "\(bookingBaseURL)/appleinfo/set"
    static let deletebooking = "\(bookingBaseURL)/draft/deletebooking"
    static let serviceInvoice = "\(bookingBaseURL)/service-invoice"
    
    //MARK: Payment API's
    static let getPaypalOrderID = "\(paymentBaseURL)/paypal/create_order_for_wallet"
    static let confirmPaypalOrderID = "\(paymentBaseURL)/paypal/capture_order"
    static let getAllTransaction = "\(paymentBaseURL)/transaction/get_all_transaction"
    static let getWalletById = "\(paymentBaseURL)/wallet/getWalletById"
    static let payCaregiverBooking = "\(paymentBaseURL)/wallet/pay_for_caregiver_booking"
    static let getBankList = "\(paymentBaseURL)/bank/get_bank_list"
    static let getOrderInvoice = "\(paymentBaseURL)/paypal/order_invoice"
    static let OrderList = "\(paymentBaseURL)/payment_history/Order_list"
    static let applePayPayment = "\(paymentBaseURL)/apple/applepay"
    //Stripe
    static let stripeCreateSetupIntent = "\(paymentBaseURL)/stripe/create-setup-intent"
    static let stripeCreateCustomer = "\(paymentBaseURL)/stripe/create-customer"
    static let stripeCharge = "\(paymentBaseURL)/stripe/charge"
    static let stripeCardList = "\(paymentBaseURL)/stripe/cardDetails"
    static let payForService = "\(paymentBaseURL)/service/pay-amount"
    static let createBankAccount = "\(paymentBaseURL)/account/create"
    static let transferAmountToAccount = "\(paymentBaseURL)/withdraw/tranferdata"
    static let transferAmountToStripe = "\(paymentBaseURL)/withdraw/amount"
    static let deleteStripeCard = "\(paymentBaseURL)/stripe/deleteCard"
    
    //MARK: Communication API's
    static let getMeetingToken = "\(communicationBaseURL)/meeting/zoom_session_token"
    static let getChatHistory = "\(communicationBaseURL)/chat/get_conversation"
    static let createConversation = "\(communicationBaseURL)/chat/create_conversation"
    static let getInboxList = "\(communicationBaseURL)/chat/contact_list"
    static let bookSlot = "\(communicationBaseURL)/meeting/book_slot"
    static let conversationWithAdmin = "\(communicationBaseURL)/chat/conversationWithAdmin"
    static let chatVideoCall = "\(communicationBaseURL)/vido_call/start"
    static let chatVideoCallRecieve = "\(communicationBaseURL)/vido_call/recieve"
    
    //MARK: Admin API's
    static let getBannerUrls = "\(adminBaseURL)/get_banner_urls"
    static let getDistanceArray = "\(adminBaseURL)/distance/get"
    static let logout = "\(authBaseURL)/authenticate/logout"
    
    //Apple pay
    static let setApplePayStatus = "https://v9hhx3kk-3000.inc1.devtunnels.ms/status/update"
}
