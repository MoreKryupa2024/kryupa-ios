//
//  StringExtention.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import Foundation
import SwiftUI

extension String{
    
    
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func validateMobile() -> Bool {
        let PHONE_REGEX = "^[2-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    
    func isValidEmail() -> Bool {
        print("validate emilId: \(self)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    
    func convertDateFormater(beforeFormat: String, afterFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = beforeFormat

        guard let date = dateFormatter.date(from: self) else {
//            assert(false, "no date from string")
            dateFormatter.dateFormat = afterFormat
            let timeStamp = dateFormatter.string(from: Date())
            return timeStamp
        }

        dateFormatter.dateFormat = afterFormat
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    
    func getFullRateVal() -> Int {
        
        var value = Int("\(self.split(separator: ".").first ?? "0")") ?? 0
        
        if value > 0 {
            value = value - 1
        }
        
        return value
    }

    func addHalfRateVal() -> Bool {
        
        let arrRate = self.split(separator: ".")
        
        if arrRate.count == 2 {
            return true
        }
        else {
            return false
        }
    }

    func getNoRateValue() -> Int {
        var totalRatingStar = getFullRateVal() + (addHalfRateVal() ? 1 : 0) + 1
        
        if totalRatingStar == 5 {
            return 0
        }
        
        if totalRatingStar > 0 {
            totalRatingStar = totalRatingStar - 1
        }
        
        return (5 - totalRatingStar)
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func removeZero()-> String{
        return String(format:"%0.0f", self)
    }
    
    func removingWhitespaces() -> String {
        let str = self.condenseWhitespace()
        return str.trimmingCharacters(in: .whitespaces)
        
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
    
    func removeZerosFromEnd(num:Int) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = num
        formatter.maximumFractionDigits = num //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}
