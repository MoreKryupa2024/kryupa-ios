//
//  PreferenceViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 24/05/24.
//

import Foundation
import SwiftUI
@MainActor
class PreferenceViewModel: ObservableObject{
    
    @Published var languageSpeakingSelected: [String] = [String]()
    @Published var preferenceListData: PreferenceList = PreferenceList()
    @Published var isLoading:Bool = false
    @Published var showPreference:Bool = false
   
    func dataChecks(parameters:[String:Any],alert:@escaping((String)->Void),next:@escaping(()->Void)){
        
        
        if languageSpeakingSelected.isEmpty{
            return alert("Please Select Speaking Language")
        }
        guard let distance = preferenceListData.distance, distance != "" else {
            return alert("Please Select Distance")
        }
        
        isLoading = true
        var param = parameters
        param["preferenceList"] = [
            "can_help_in": preferenceListData.canHelpIn ?? [],
            "language": languageSpeakingSelected,
            "distance": distance
        ]
        
        NetworkManager.shared.postCareGiverCreateProfile(params: param) { [weak self] result in
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
