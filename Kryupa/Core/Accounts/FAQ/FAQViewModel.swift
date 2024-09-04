//
//  FAQViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 02/08/24.
//

import Foundation
import SocketIO

class FAQViewModel: ObservableObject{
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    @Published var selectedSection = 0
    @Published var faqModelData: FAQModelData?
    @Published var sendMsgText: String = ""
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    @Published var isLoading = Bool()
    
    var faq: [AboutUsData] {
        if AppConstants.SeekCare == Defaults().userType{
            return [
                AboutUsData(title: "How does Kryupa ensure the quality of caregivers?", desc: "All caregivers on Kryupa undergo a thorough background check and verification process before being allowed to offer their services. This ensures that only qualified and trustworthy caregivers are available on the platform."),
                AboutUsData(title: "Can I book multiple caregivers for different family members?", desc: "Yes, you can add up to 5 profiles for your loved ones in a single account and book separate caregivers for each profile according to their specific needs."),
                AboutUsData(title: "How do payments work on Kryupa?", desc: "Payments are processed through the app once the caregiver accepts the booking created by the careseeker."),
                AboutUsData(title: "How can I cancel a booking?", desc: "You can cancel a booking directly through the app in the Bookings section. Cancellations are allowed if the booking is in the scheduled state or if it's an active recurring booking. Additionally, caregivers also have the option to cancel bookings from their end in case of any inconvenience."),
                AboutUsData(title: "How do I track my appointments?", desc: "You can view upcoming, past, and cancelled appointments in the Bookings section of the app."),
                AboutUsData(title: "What should I do if I need help or support?", desc: "Kryupa offers in-app chat support for any help or assistance. You can access this under the Help & FAQ section."),
                AboutUsData(title: "What happens if a caregiver declines my booking request?", desc: "If a caregiver declines your request, you'll receive a notification, and you can easily search for other available caregivers that meet your needs."),
                AboutUsData(title: "Can I update my profile information?", desc: "Yes, you  can update their personal information at any time through the account settings in the app."),
                AboutUsData(title: "How do I give feedback or reviews?", desc: "After a service is completed or canceled , you’ll have the opportunity to rate and review your caregiver. Your feedback helps improve the quality of services on Kryupa.")
            ]
        }else{
            return [
                AboutUsData(title: "How do I accept or decline a booking request?", desc: "To accept or decline a booking, go to your 'Jobs' or 'Bookings' section, review the details, and click the 'Accept' or 'Decline' button. You’ll receive a confirmation notification once the booking is accepted or declined."),
                AboutUsData(title: "How do I cancel a booking?", desc: "If you need to cancel a booking, navigate to your 'Bookings' section, find the booking, and select 'Cancel.' You can cancel if the booking is scheduled or if it’s an active recurring booking. Please try to notify the care seeker as early as possible."),
                AboutUsData(title: "When and how will I receive my payments?", desc: "Payments are processed weekly by Kryupa and will be deposited directly into your registered bank account. Ensure your bank details are up to date in the app to avoid payment delays."),
                AboutUsData(title: "How can I update my profile or add new skills?", desc: "To update your profile, go to the 'Account' section, where you can edit your personal details, add new skills, and more. Keeping your profile updated helps you attract more bookings."),
                AboutUsData(title: "What happens if a care seeker cancels a booking?", desc: "If a care seeker cancels a booking, you will receive a notification through the app. If the cancellation affects your schedule significantly, you can reach out to our support team for assistance.'Account' section, where you can edit your personal details, add new skills, and more. Keeping your profile updated helps you attract more bookings."),
                AboutUsData(title: "How do I refer another caregiver to Kryupa?", desc: "You can refer other caregivers by navigating to the 'Refer & Earn' section in the app. Share your referral code, and for every successful onboarding, you can earn up to $25."),
                AboutUsData(title: "What should I do if I face an issue during a service?", desc: "If you encounter any issues during a service, use the 'Help & FAQ' option within the app to get immediate assistance from our support team. You can also report the issue after the service is completed."),
                AboutUsData(title: "How do I give feedback or reviews?", desc: "After a service is completed or canceled , you’ll have the opportunity to rate and review your careseeker. Your feedback helps improve the quality of services on Kryupa.")
            ]
        }
    }
    
    init(){
        self.manager = SocketManager(socketURL: URL(string: "\(APIConstant.communicationBaseURL)/")!, config: [.log(true), .compress])
        self.socket = self.manager.defaultSocket
    }
    
    func connect() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            //Call your first socket here
        }
        let param = ["Authorization": "bearer \(Defaults().accessToken)"]
        socket.connect(withPayload: param)
    }

    func disconnect() {
        socket.disconnect()
    }
    
    func sendMessage(_ message: String) {
        
        let msgData = AllConversationData(jsonData: [
            "id": "\(UUID())",
            "message": message,
            "sender":faqModelData?.userId ?? "",
            "recipient":faqModelData?.adminId ?? ""
        ])
        let param = ["contact_Id":faqModelData?.contactID ?? "",
                     "sender_id":faqModelData?.userId ?? "",
                     "recipient_id":faqModelData?.adminId ?? "",
                     "Authorization": "bearer \(Defaults().accessToken)",
                     "message":message]
        
        socket.emit("help_chat", with: [param]) {
            DispatchQueue.main.async {
                self.faqModelData?.allConversation.append(msgData)
            }
        }
    }
    
    func receiveMessage() {
        socket.on("message_receive") { [weak self] data, _ in
            guard let self else {return}
            if let typeDict = data[0] as? NSDictionary {
                
                let message = typeDict.value(forKey: "message") as? String ?? ""
                HapticManager.sharde.impact(style: .heavy)
                let msgData = AllConversationData(jsonData: [
                    "id": "\(UUID())",
                    "message": message,
                    "sender":faqModelData?.adminId ?? "",
                    "recipient":faqModelData?.userId ?? "",
                ])
                DispatchQueue.main.async {
                    self.faqModelData?.allConversation = [msgData] + (self.faqModelData?.allConversation ?? [])
                }
            }
        }
    }
    
    func conversationWithAdmin(){
//        let param = ["pageNumber":pageNumber,
        let param = ["pageNumber":1,
                     "pageSize":20]
        isLoading = true
        NetworkManager.shared.conversationWithAdmin(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let data):
                    /*  if self!.pageNumber > 1{
                     self?.faqModelData?.allConversation += data.data.allConversation
                 }else{
                     self?.faqModelData = data.data
                 }
                 self?.pagination = data.data.allConversation.count != 0
                 */
                    self?.faqModelData = data.data
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }
}
