//
//  PersonalInformationScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 17/05/24.
//

import Foundation
import SwiftUI

class PersonalInformationScreenViewModel: ObservableObject{
    
    var date: Date = Date()
    @Published var showDatePicker: Bool = Bool()
    var dateOfBirthSelected: Bool = Bool()
    @Published var personalInfoData: PersonalInfo = PersonalInfo()

    func dateFormatter(formate:String? = nil)-> String{
        let formatter = DateFormatter()
        if let formate{
            formatter.dateFormat = formate
        }else{
            formatter.dateStyle = .short
        }
        return formatter.string(
            from: self.date
        )
    }
    
    
    
    func dataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        guard let name = personalInfoData.name, name != "" else {
            return alert("Please Enter Legal Name")
        }
        
        guard let dob = personalInfoData.dob, dob != "" else {
            return alert("Please Enter Date Of Birth")
        }
        guard let gender = personalInfoData.gender, gender != "" else {
            return alert("Please Enter Gender")
        }
        guard let ssn = personalInfoData.ssn, ssn != "" else {
            return alert("Please Enter SSN No.")
        }
        guard let language = personalInfoData.language, language != "" else {
            return alert("Please Enter Language")
        }
        guard let address = personalInfoData.address, address != "" else {
            return alert("Please Enter Address")
        }
        guard let city = personalInfoData.city, city != "" else {
            return alert("Please Enter City")
        }
        guard let state = personalInfoData.state, state != "" else {
            return alert("Please Enter State")
        }
        guard let country = personalInfoData.country, country != "" else {
            return alert("Please Enter Country")
        }
        var param = [String:Any]()
        param["personalInfo"] = ["name": name,
                                 "language": language,
                                 "dob": dob,
                                 "gender": gender,
                                 "latitude": personalInfoData.latitude ?? 0.0,
                                 "longitude": personalInfoData.latitude ?? 0.0,
                                 "address": address,
                                 "city": city,
                                 "state": state,
                                 "country": country,
                                 "ssn_no":ssn]
        
        next(param)
    }
    
    func customerDataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        guard let name = personalInfoData.name, name != "" else {
            return alert("Please Enter Legal Name")
        }
        
        guard let dob = personalInfoData.dob, dob != "" else {
            return alert("Please Enter Date Of Birth")
        }
        guard let gender = personalInfoData.gender, gender != "" else {
            return alert("Please Enter Gender")
        }
        
        guard let language = personalInfoData.language, language != "" else {
            return alert("Please Enter Language")
        }
        guard let address = personalInfoData.address, address != "" else {
            return alert("Please Enter Address")
        }
        guard let city = personalInfoData.city, city != "" else {
            return alert("Please Enter City")
        }
        guard let state = personalInfoData.state, state != "" else {
            return alert("Please Enter State")
        }
        guard let country = personalInfoData.country, country != "" else {
            return alert("Please Enter Country")
        }
        var param = [String:Any]()
        param["personalInfo"] = ["name": name,
                                 "language": language,
                                 "dob": dob,
                                 "gender": gender,
                                 "latitude": personalInfoData.latitude ?? 0.0,
                                 "longitude": personalInfoData.latitude ?? 0.0,
                                 "address": address,
                                 "city": city,
                                 "state": state,
                                 "country": country]
        
        next(param)
    }
}
