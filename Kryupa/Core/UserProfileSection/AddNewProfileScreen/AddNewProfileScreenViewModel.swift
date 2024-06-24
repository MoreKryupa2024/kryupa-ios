//
//  AddNewProfileScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import Foundation
import SwiftUI

@MainActor
class AddNewProfileScreenViewModel: ObservableObject{
    
    @Published var isLoading:Bool = false

    @Published var name: String = String()
    @Published var email: String = String()
    @Published var relation: String = String()
    @Published var number: String = String()
    @Published var relationPersonal: String = String()
    @Published var profileID: String = String()
    @Published var medicalID: String = String()

    var date: Date = Date()
    @Published var showDatePicker: Bool = Bool()
    var dateOfBirthSelected: Bool = Bool()
    @Published var personalInfoData: PersonalInfo = PersonalInfo()
    
    
    @Published var medicalConditionSelected: String = String()
    @Published var medicalConditionDropDownSelected: [String] = [String]()
    @Published var mobilityLevel: String = String()
    @Published var allergiesValue: String = String()
    
    @Published var param = [String:Any]()
    
    func dataMedicalChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        if medicalConditionDropDownSelected.isEmpty {
            return alert("Please Select Medical Condition")
        }else if medicalConditionDropDownSelected.contains("Other"){
            return alert("Please Enter Other Medical Condition")
        }else if mobilityLevel.isEmpty{
            return alert("Please Select Mobility Level")
        }else{
             var param = [String:Any]()
             param = [
                 "allergies": allergiesValue,
                 "mobility_level": mobilityLevel,
                 "other_disease_type": medicalConditionSelected,
                 "disease_type": medicalConditionDropDownSelected
             ]
            next(param)
        }
    }
    
    
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
    
    func dataEmergancyChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        if name.isEmpty {
            return alert("Please Enter Name")
        }else if relation.isEmpty{
            return alert("Please Select Your Relation")
        }else if !email.isValidEmail() {
            return alert("Please Enter Email")
        }else if !number.validateMobile(){
            return alert("Please Enter Mobile No.")
        }else{
             var param = [String:Any]()
             param = [
                 "relative_name": name,
                 "relation": relation,
                 "relative_email": email,
                 "relative_mobile_no": number
             ]
            next(param)
        }
    }
    
    func customerDataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        if relationPersonal.isEmpty{
            return alert("Please Select Your Relation")
        }
        
        guard let name = personalInfoData.name, name != "" else {
            return alert("Please Enter Full Legal Name")
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
        param = ["name": name,
                 "language": language,
                 "dob": dob,
                 "gender": gender,
                 "latitude": personalInfoData.latitude ?? 0.0,
                 "longitude": personalInfoData.latitude ?? 0.0,
                 "address": address,
                 "city": city,
                 "state": state,
                 "country": country,
                 "relation": relationPersonal]
        
        next(param)
    }
    
    func createProfile(next: @escaping (()->Void), errorMsg: @escaping ((String)->Void)){
        isLoading = true
        NetworkManager.shared.addNewProfile(params: param) { [weak self] result in
            switch result{
            case .success(_):
                self?.isLoading = false
                next()
            case .failure(let error):
                self?.isLoading = false
                errorMsg(error.getMessage())
                print(error)
            }
        }
    }
    
    func updateProfile(next: @escaping (()->Void)){
        
        param["profileId"] = profileID
        isLoading = true
        NetworkManager.shared.updateProfile(params: param) { [weak self] result in
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
