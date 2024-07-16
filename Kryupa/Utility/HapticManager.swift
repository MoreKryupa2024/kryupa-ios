//
//  HapticManager.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 03/07/24.
//

import SwiftUI

class HapticManager {
    
    static let sharde  = HapticManager()
    
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
