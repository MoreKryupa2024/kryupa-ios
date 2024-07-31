//
//  SettingViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 31/07/24.
//

import Foundation
import SwiftUI

@MainActor
class SettingViewModel: ObservableObject{
    @Published var state = true
    @Published var isloading = false
    @Published var arrNotificationAlert: [NotificationAlertData] = [
        NotificationAlertData(title: "Get notified about our latest updates:", toggleState: false),
        NotificationAlertData(title: "Get SMS alerts:", toggleState: false),
        NotificationAlertData(title: "Subscribe to our newsletter:", toggleState: false),
        NotificationAlertData(title: "WhatsApp notification:", toggleState: false)
    ]
    @Published var selectedOption = "No, Deactivate my account till next login"
    @Published var arrcheckList: [NotificationAlertData] = [
        NotificationAlertData(title: "Yes, I am sure", toggleState: false),
        NotificationAlertData(title: "No, Deactivate my account till next login", toggleState: false)
    ]
    
    func getNotificationSetting(){
        isloading = true
        
        NetworkManager.shared.getNotification { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.arrNotificationAlert[0].toggleState = data.data.getNotificationAboutOurLatestUpdates
                    self?.arrNotificationAlert[1].toggleState = data.data.getSMSAlert
                    self?.arrNotificationAlert[2].toggleState = data.data.subscribeToOurNewsletter
                    self?.arrNotificationAlert[3].toggleState = data.data.whatsappNotification
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func updateNotificationSetting(){
        isloading = true
        let param = ["get_notification_about_our_latest_updates":arrNotificationAlert[0].toggleState,
                     "get_sms_alert":arrNotificationAlert[1].toggleState,
                     "subscribe_to_our_newsletter":arrNotificationAlert[2].toggleState,
                     "whatsapp_notification":arrNotificationAlert[3].toggleState]
        
        NetworkManager.shared.updateNotification(params:param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    print()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func deleteAccount(){
        isloading = true
        let param = ["is_deleted":arrcheckList[0].title == selectedOption,
                     "is_inactive":arrcheckList[1].title == selectedOption]
        
        NetworkManager.shared.deleteAccount(params:param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    let domain = Bundle.main.bundleIdentifier!
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    NotificationCenter.default.post(name: .logout,
                                                    object: nil, userInfo: nil)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
