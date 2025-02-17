//
//  HealthInformationSeekerViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 27/05/24.
//

import Foundation
import SwiftUI
@MainActor
class HealthInformationSeekerViewModel: ObservableObject{
    
    @Published var medicalConditionSelected: String = String()
    @Published var medicalConditionDropDownSelected: [String] = [String]()
    @Published var canHelpInSelect: [String] = []
    @Published var allergiesValue: String = String()
    @Published var isLoading: Bool = false
    
    func dataChecks(parameters:[String:Any],alert:@escaping((String)->Void),next:@escaping (()->Void)){
        var params = parameters
        
        medicalConditionSelected = medicalConditionSelected.removingWhitespaces()
        allergiesValue = allergiesValue.removingWhitespaces()
        if medicalConditionDropDownSelected.isEmpty {
            return alert("Please Select Medical Condition")
        }else if medicalConditionDropDownSelected.contains("Other") && medicalConditionSelected.isEmpty{
            return alert("Please Enter Other Medical Condition")
        }else{
             var param = [String:Any]()
             param = [
                 "allergies": allergiesValue,
                 "can_help_in": canHelpInSelect,
                 "other_disease_type": medicalConditionSelected,
                 "disease_type": medicalConditionDropDownSelected
             ]
            params["medicalInfo"] = param
            self.isLoading = true
            NetworkManager.shared.postCareSeekerCreateProfile(params: params) { [weak self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(_):
                        self?.isLoading = false
                        next()
                    case .failure(let error):
                        self?.isLoading = false
                        alert(error.getMessage())
                        print(error)
                    }
                }
            }
        }
    }
}
