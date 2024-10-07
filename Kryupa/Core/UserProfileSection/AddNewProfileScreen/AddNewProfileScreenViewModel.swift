//
//  AddNewProfileScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
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
    @Published var canHelpInSelect: [String] = []
    @Published var allergiesValue: String = String()
    
    @Published var param = [String:Any]()
    
    func getAddress(){
        let param = ["zipcode":personalInfoData.postalCode ?? ""]
        NetworkManager.shared.getAddress(params: param) { result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self.personalInfoData.latitude = Double(data.data.places.first?.latitude ?? "") ?? 0.0
                    self.personalInfoData.longitude = Double(data.data.places.first?.longitude ?? "") ?? 0.0
                    self.personalInfoData.state = data.data.places.first?.state ?? ""
                    self.personalInfoData.city = data.data.places.first?.placeName ?? ""
                    self.personalInfoData.country = data.data.country
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.personalInfoData.zipError = "Postal code not found!"
                }
            }
        }
    }
    
    func dataMedicalChecks(alert:((String)->Void),next:(([String:Any])->Void)){
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
    
    func customerDataChecks(alert:((String)->Void),next:(([String:Any])->Void)){
        
        if relationPersonal.isEmpty{
            return alert("Please Select Your Relation")
        }
        personalInfoData.name = (personalInfoData.name ?? "").removingWhitespaces()
        guard let name = personalInfoData.name, name != "" else {
            return alert("Please Enter First Name")
        }
        personalInfoData.lastName = (personalInfoData.lastName ?? "").removingWhitespaces()
        guard let lastName = personalInfoData.lastName, lastName != "" else {
            return alert("Please Enter Last Name")
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
        guard let postalCode = personalInfoData.postalCode, postalCode != "" else {
            return alert("Please Enter Zip Code")
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
        param = ["firstname":name,
                 "lastname":lastName,
                 "language": language,
                 "dob": dob,
                 "gender": gender,
                 "latitude": personalInfoData.latitude ?? 0.0,
                 "longitude": personalInfoData.latitude ?? 0.0,
                 "address": address,
                 "zipcode": postalCode,
                 "city": city,
                 "state": state,
                 "country": country,
                 "relation": relationPersonal]
        
        next(param)
    }
    
    func createProfile(next: @escaping (()->Void), errorMsg: @escaping ((String)->Void)){
        isLoading = true
        NetworkManager.shared.addNewProfile(params: param) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    self?.isLoading = false
                    next()
                case .failure(let error):
                    self?.isLoading = false
                    errorMsg(error.getMessage())
                }
            }
        }
    }
    
    func updateProfile(next: @escaping (()->Void)){
        
        param["profileId"] = profileID
        isLoading = true
        NetworkManager.shared.updateProfile(params: param) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    self?.isLoading = false
                    next()
                case .failure(let error):
                    self?.isLoading = false
                }
            }
        }
    }
}
