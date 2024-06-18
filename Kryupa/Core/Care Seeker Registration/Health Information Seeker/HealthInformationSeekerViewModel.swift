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
    @Published var mobilityLevel: String = String()
    @Published var allergiesValue: String = String()
    
    func dataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        if medicalConditionDropDownSelected.isEmpty {
            return alert("Please Select Medical Condition")
        }else if medicalConditionDropDownSelected.contains("Other") && medicalConditionSelected.isEmpty{
            return alert("Please Enter Other Medical Condition")
        }else if mobilityLevel.isEmpty{
            return alert("Please Select Mobility Level")
        }else{
             var param = [String:Any]()
             param = [
                 "allergies": allergiesValue,
                 "mobility_level": mobilityLevel,
                 "other_disease_type": medicalConditionSelected,
                 "disease_type": [medicalConditionDropDownSelected]
             ]
            next(param)
        }
    }
}
