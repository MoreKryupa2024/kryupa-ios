//
//  MobileScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 02/07/24.
//

import Foundation

@MainActor
class MobileScreenViewModel: ObservableObject{
    
    @Published var mobileNumner: String = String()
    @Published var sendOTPdata: SendOTPData?
    @Published var mobileIsFocused: Bool = false
    @Published var isLoading:Bool = false
    
    
    func sendOTP(action :  @escaping() -> Void,errorAction :  @escaping (String) -> Void){
        let param = ["mobile_no":mobileNumner.applyPatternOnNumbers(pattern: "##########", replacementCharacter: "#"),
                     "country_code":"1"]
        isLoading = true
        NetworkManager.shared.sendOTP(params: param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(let data):
                    self?.sendOTPdata = data.data
                    action()
                case .failure(let error):
                    errorAction(error.getMessage())
                }
            }
            
        }
    }
    
    func verifyOTP(param:[String:Any],action :  @escaping() -> Void,errorAction :  @escaping (String) -> Void){
        isLoading = true
        NetworkManager.shared.verifyOTP(params: param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result{
                case .success(_):
                    action()
                case .failure(let error):
                    errorAction(error.getMessage())
                }
            }
            
        }
    }
}
