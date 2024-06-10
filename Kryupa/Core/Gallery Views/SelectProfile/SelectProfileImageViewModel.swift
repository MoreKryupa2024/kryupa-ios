//
//  SelectProfileImageViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 27/05/24.
//

import Foundation
import SwiftUI
import AVFoundation

class SelectProfileImageViewModel: ObservableObject{
//    @Published var camera = CameraModal()
    let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
    @Published var profileSelected: Bool = false
    @Published var profilePicture: UIImage? = nil
    @Published var isLoading:Bool = false
    
    func uploadProfilePic(file:Data, fileName: String, certificateUrl: @escaping(()->Void)){
        isLoading = true
        NetworkManager.shared.uploadProfile(file: file, fileName: fileName) {[weak self] result in
            switch result{
            case .success(_):
                self?.isLoading = false
                certificateUrl()
            case .failure(let error):
                self?.isLoading = false
                print(error)
            }
        }
    }
}

class CameraModal: ObservableObject{
    @Published var isTaken: Bool = false
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            
        })
    }
}
