//
//  PreferenceCareSeekarViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 27/05/24.
//

import Foundation
import SwiftUI
@MainActor
class PreferenceCareSeekarViewModel: ObservableObject{
    
    @Published var yearsOfExperienceSelected: String = "Any"
    @Published var genderSelected: String = String()
    @Published var needServiceInSelected: [String] = [String]()
    @Published var languageSpeakingSelected: [String] = ["English"]
    @Published var isLoading:Bool = false
    @Published var showPreference:Bool = false
    
    func dataChecks(parameters:[String:Any],alert: @escaping ((String)->Void),next: @escaping (()->Void)){
        
        if yearsOfExperienceSelected.isEmpty {
            return alert("Please Select Years Of Experience")
        }else if genderSelected.isEmpty{
            return alert("Please Select Gender")
        }else if needServiceInSelected.isEmpty{
            return alert("Please Select Service")
        }else if languageSpeakingSelected.isEmpty{
            return alert("Please Select Speaking Language")
        }else{
            isLoading = true
            var param = parameters
            param["preferences"] = [
                "preferredLanguageType": languageSpeakingSelected,
                "gender": genderSelected,
                "year_of_experience": yearsOfExperienceSelected,
                "preferredServiceType":needServiceInSelected
            ]
            
            NetworkManager.shared.postCareSeekerCreateProfile(params: param) { [weak self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(_):
                        self?.isLoading = false
                        next()
                    case .failure(let error):
                        self?.isLoading = false
                        print(error)
                    }
                }
            }
        }
    }
}
