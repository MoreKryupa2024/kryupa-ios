//
//  ZoomScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 11/06/24.
//

import SwiftUI
import UIKit
import ZoomVideoSDKUIToolkit

struct ZoomScreenView: UIViewControllerRepresentable {
    
    var vc = ViewController()
    var jwt = "JWT"
    var sessionName = ""
    var sessionPassword = ""
    var username = ""
    var toolkitErrorAction: (UIToolkitError) -> Void
    var onViewLoadedAction: () -> Void
    var onViewDismissedAction: () -> Void
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Return MyViewController instance
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
        vc.jwt = jwt
        vc.sessionName = sessionName
        vc.username = username
        vc.sessionPassword = sessionPassword
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(vc: vc, toolkitErrorAction: self.toolkitErrorAction, onViewLoadedAction: self.onViewLoadedAction, onViewDismissedAction: self.onViewDismissedAction)
    }
    
    class Coordinator: NSObject, UIToolkitDelegate {
        
        var toolkitErrorAction: (UIToolkitError) -> Void
        var onViewLoadedAction: () -> Void
        var onViewDismissedAction: () -> Void
        
        init(vc: ViewController, toolkitErrorAction: @escaping (UIToolkitError) -> Void, onViewLoadedAction: @escaping () -> Void, onViewDismissedAction: @escaping () -> Void) {
            self.toolkitErrorAction = toolkitErrorAction
            self.onViewLoadedAction = onViewLoadedAction
            self.onViewDismissedAction = onViewDismissedAction
            super.init()
            vc.delegate = self
        }
        
        func onError(_ errorType: UIToolkitError) {
            print("Sample VC onError Callback: \(errorType.rawValue) -> \(errorType.description)")
            self.toolkitErrorAction(errorType)
        }
        
        func onViewLoaded() {
            onViewLoadedAction()
        }
        
        func onViewDismissed() {
            onViewDismissedAction()
        }
    }
}

class ViewController: UIViewController {
    
    var jwt = "JWT"
    var sessionName = ""
    var username = ""
    var sessionPassword = ""
    var delegate: UIToolkitDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        present()
    }
    
    func present(){
        let vc = UIToolkitVC(sessionContext: SessionContext(jwt: jwt, sessionName: sessionName, sessionPassword: sessionPassword, username: username))
        vc.delegate = self.delegate
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
