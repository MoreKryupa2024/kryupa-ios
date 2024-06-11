//
//  ZoomScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 11/06/24.
//

import SwiftUI
import UIKit
import ZoomVideoSDKUIToolkit

struct ZoomScreenView: UIViewControllerRepresentable {
    
    var vc = ViewController()
    
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
        vc.jwt = "JWT token"
        vc.sessionName = "sessionName"
        vc.username = "username"
        vc.present()
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
    var delegate: UIToolkitDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(jwt,sessionName,username)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(jwt,sessionName,username)
        present()
    }
    
    func present(){
        let vc = UIToolkitVC(sessionContext: SessionContext(jwt: jwt, sessionName: sessionName, username: username))
        vc.delegate = self.delegate
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
