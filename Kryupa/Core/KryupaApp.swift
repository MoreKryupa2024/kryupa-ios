//
//  KryupaApp.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import SwiftUI
import SwiftfulRouting
import GoogleSignIn
import FirebaseCore
import IQKeyboardManagerSwift
import FirebaseMessaging
import AVFoundation

@main
struct KryupaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert,.badge,.sound,.criticalAlert]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in}
        application.registerForRemoteNotifications()
        
        Messaging.messaging().token { token, error in
            if let error{
                print("Notifications----------------------Firebase Message error:-\(error)")
            }else if let token{
                print("Notifications----------------------Firebase Message token:- \(token)")
            }
        }
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Notifications----------------------Firebase Message FCM token:- \(String(describing: fcmToken))")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        print("Notifications----------------------did Fail To Register For Remote Notifications With Error :-\(error)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var readableToken = String()
        for index in 0 ..< deviceToken.count {
            readableToken += String(format: "%02.2hhx",deviceToken[index] as CVarArg)
        }
        print("Notifications----------------------Recived an APNS Device Token\(readableToken)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notifications----------------------user Notification Center willPresent")
        //        completionHandler([.alert, .sound, .badge])
        AudioServicesPlaySystemSound(1026)
        HapticManager.sharde.impact(style: .heavy)
        if #available(iOS 14.0, *) {
            completionHandler([.list, .banner, .sound])
        } else {
            completionHandler([.alert, .banner, .sound])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Notifications----------------------user Notification Center didReceive")
        let notiInfo = response.notification.request.content.userInfo
        print(notiInfo)
        if let notiInfo = notiInfo as? [String:Any],let screenName = notiInfo["screenName"] as? String , screenName == "ChatScreen"  {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationCenter.default.post(name: .showInboxScreen,object: nil,userInfo: notiInfo)
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Notifications----------------------user Notification Center didReceive")
    }
}
