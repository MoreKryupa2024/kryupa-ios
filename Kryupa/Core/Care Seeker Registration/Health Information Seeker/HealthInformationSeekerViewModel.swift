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
    
    func dataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
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
            next(param)
        }
    }
}
