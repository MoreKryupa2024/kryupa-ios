//
//  EmergencyContactViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 27/05/24.
//

import Foundation
import SwiftUI
@MainActor
class EmergencyContactViewModel: ObservableObject{
    
    @Published var name: String = String()
    @Published var email: String = String()
    @Published var relation: String = String()
    @Published var number: String = String()
    
    func dataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        name = name.removingWhitespaces()
        if name.isEmpty {
            return alert("Please Enter Name")
        }else if relation.isEmpty{
            return alert("Please Select Your Relation")
        }else if !email.isValidEmail() {
            return alert("Please Enter Email")
        }else if !number.applyPatternOnNumbers(pattern: "##########", replacementCharacter: "#").validateMobile(){
            return alert("Please Enter 10-Digit Mobile No.")
        }else{
             var param = [String:Any]()
             param = [
                 "relative_name": name,
                 "relation": relation,
                 "relative_email": email,
                 "relative_mobile_no": number.applyPatternOnNumbers(pattern: "##########", replacementCharacter: "#")
             ]
            next(param)
        }
    }
}
