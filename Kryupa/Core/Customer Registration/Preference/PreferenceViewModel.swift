//
//  PreferenceViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 24/05/24.
//

import Foundation
import SwiftUI

class PreferenceViewModel: ObservableObject{
    
    @Published var preferenceListData: PreferenceList = PreferenceList()
    @Published var isLoading:Bool = false
    
    func dataChecks(parameters:[String:Any],alert:@escaping((String)->Void),next:@escaping(()->Void)){
        isLoading = true
        
        guard let mobilityLevel = preferenceListData.mobilityLevel, mobilityLevel != "" else {
            return alert("Please Select Mobility Level")
        }
        
        guard let language = preferenceListData.language, language != "" else {
            return alert("Please Select Language")
        }
        guard let distance = preferenceListData.distance, distance != "" else {
            return alert("Please Select Distance")
        }
        
       
        var param = parameters
        param["preferenceList"] = [
            "mobility_level": mobilityLevel,
            "language": language,
            "distance": distance
        ]
        
        NetworkManager.shared.postCareGiverCreateProfile(params: param) { [weak self] result in
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
