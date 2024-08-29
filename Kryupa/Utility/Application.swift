//
//  Application.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 22/05/24.
//

import SwiftUI
import UIKit

final class ApplicationUtility {
    static var rootViewController: UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

func dismissingKeyboardGlobal(){
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    keyWindow?.endEditing(true)
}

extension View{
    func presentAlert(title: String, subTitle: String, primaryAction: UIAlertAction? = nil, secondaryAction: UIAlertAction? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
            if let primaryAction{
                alertController.addAction(primaryAction)
            }else{
                let action = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(action)
            }
            if let secondary = secondaryAction {
                alertController.addAction(secondary)
            }
            ApplicationUtility.rootViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
