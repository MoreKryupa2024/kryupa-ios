//
//  Defaults.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 22/05/24.
//

import Foundation
//import SecureDefaults

enum DefaultKeys: String {
  case accessToken
  case refreshToken
  case deviceToken
  case userType
  case apiKey
  case firstName
  case lastName
  case email
  case mobile
}

class Defaults {
  
//    private let userDefaults = SecureDefaults.shared
    private let userDefaults = UserDefaults.standard
    
    init()
    {
        setKeyIfNotSetAlready()
    }
    
    
    /*func logoutUser(_ completion: (() -> Void)? = nil){
        
        let referralTempData = referralData
        let deepLinkTempData = deepLinkData
        let removeCardCoachMarkShownTempData = removeCardCoachMarkShown
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        referralData = referralTempData
        deepLinkData = deepLinkTempData
        removeCardCoachMarkShown = removeCardCoachMarkShownTempData
        completion?()
    }*/
  
  var accessToken: String {
    get {
      return getStringValue(key: .accessToken)
    } set {
      set(value: newValue, key: .accessToken)
    }
  }
  
  var userType: String {
    get {
      return getStringBannerValue(key: .userType)
    } set {
      set(value: newValue, key: .userType)
    }
  }
  
  var refreshToken: String {
    get {
      return getStringValue(key: .refreshToken)
    } set {
      set(value: newValue, key: .refreshToken)
    }
  }
  
  
  
  var deviceToken: String {
    get {
      return getStringValue(key: .deviceToken)
    } set {
      set(value: newValue, key: .deviceToken)
    }
  }
  
  var email: String {
    get {
      return getStringValue(key: .email)
    } set {
      set(value: newValue, key: .email)
    }
  }
  
  var apiKey: String {
    get {
      return getStringValue(key: .apiKey)
    } set {
      set(value: newValue, key: .apiKey)
    }
  }
  
  var firstName: String {
    get {
      return getStringValue(key: .firstName)
    } set {
      set(value: newValue, key: .firstName)
    }
  }
  
  var lastName: String {
    get {
      return getStringValue(key: .lastName)
    } set {
      set(value: newValue, key: .lastName)
    }
  }
  
  var mobile: Int {
    get {
      return getIntegerValue(key: .mobile)
    } set {
      set(value: newValue, key: .mobile)
    }
  }
}

fileprivate extension Defaults {
  func set(value: Any, key: DefaultKeys) {
    userDefaults.set(value, forKey: key.rawValue)
    userDefaults.synchronize()
  }
    
  func getStringValue(key: DefaultKeys) -> String {
    return (userDefaults.value(forKey: key.rawValue) as? String) ?? ""
  }
  
  func getStringBannerValue(key: DefaultKeys) -> String {
    return (userDefaults.value(forKey: key.rawValue) as? String) ?? "NO_EMAIL_LINKED"
  }
  
  func getValues(key: DefaultKeys) -> [String] {
    return (userDefaults.value(forKey: key.rawValue) as? [String]) ?? []
  }
  
  func getBoolValue(key: DefaultKeys) -> Bool {
    return (userDefaults.value(forKey: key.rawValue) as? Bool) ?? false
  }
  
  func getDoubleValue(key: DefaultKeys) -> Double {
    return (userDefaults.value(forKey: key.rawValue) as? Double) ?? 0.0
  }
  
  func getDateValue(key: DefaultKeys) -> Date? {
    return (userDefaults.value(forKey: key.rawValue) as? Date)
  }
  
  func getIntegerValue(key: DefaultKeys) -> Int {
    return (userDefaults.value(forKey: key.rawValue) as? Int) ?? 0
  }
  
  func getDictionary(key: DefaultKeys) -> [String: Any] {
    return (userDefaults.object(forKey: key.rawValue) as? [String: Any]) ?? [:]
  }
  
  func getDictionary(key: DefaultKeys) -> [String: String] {
    return (userDefaults.object(forKey: key.rawValue) as? [String: String]) ?? [:]
  }
  
  func getValues(key: DefaultKeys) -> [Int] {
    return (userDefaults.value(forKey: key.rawValue) as? [Int]) ?? []
  }
    
 private func setKeyIfNotSetAlready() {
//        if !userDefaults.isKeyCreated {
//              userDefaults.password = NSUUID().uuidString // Or any password you wish
//        }
    }

    func setCodable<T: Codable>(_ object: T, key: DefaultKeys) {
        do {
            let data = try JSONEncoder().encode(object)
            userDefaults.set(data, forKey: key.rawValue)
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func getCodable<T: Codable>(for key: DefaultKeys) -> T? {
        do {
            guard let data = userDefaults.data(forKey: key.rawValue) else {
                return nil
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Error decoding: \(error)")
            return nil
        }
    }
}

