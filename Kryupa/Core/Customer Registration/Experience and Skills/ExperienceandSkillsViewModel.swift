//
//  ExperienceandSkillsViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 24/05/24.
//

import Foundation
import SwiftUI

class ExperienceandSkillsViewModel: ObservableObject{
    
    @Published var exprienceAndSkillsData: ExprienceAndSkills = ExprienceAndSkills()
    @Published var showFilePicker: Bool = false
    @Published var areaOfExpertiseSelected: [String] = [String]()
    @Published var isLoading:Bool = false
    
    func dataChecks(filesArray:[FileData],alert:((String)->Void),next:(([String:Any])->Void)){
        
        exprienceAndSkillsData.areaOfExpertise = areaOfExpertiseSelected
        var certificateAndDocuments = [String]()
        for i in filesArray{
            certificateAndDocuments.append(i.serverUrl)
        }
        exprienceAndSkillsData.certificateAndDocuments = certificateAndDocuments
        
        guard let bio = exprienceAndSkillsData.bio, bio != "" else {
            return alert("Please Enter Bio")
        }
        
        guard let yearsOfExprience = exprienceAndSkillsData.yearsOfExprience, yearsOfExprience != "" else {
            return alert("Please Select Years Of Exprience")
        }
        guard let areaOfExpertise = exprienceAndSkillsData.areaOfExpertise, areaOfExpertise.count != 0 else {
            return alert("Please Select Area Of Expertise")
        }
        
        guard let certificateAndDocuments = exprienceAndSkillsData.certificateAndDocuments, certificateAndDocuments.count != 0 else {
            return alert("Please Upload Your Certificate & Documents")
        }
       
        var param = [String:Any]()
        param = [
            "bio": bio,
            "area_of_expertise": areaOfExpertise,
            "certificate_and_documents": certificateAndDocuments,
            "years_of_exprience": yearsOfExprience,
        ]
        
        next(param)
    }
    
    func uploadCertificateAndDocuments(file:Data, fileName: String, certificateUrl: @escaping((String)->Void)){
        isLoading = true
        NetworkManager.shared.uploadPDFFile(file: file, fileName: fileName) {[weak self] result in
            switch result{
            case .success(let data):
                self?.isLoading = false
                certificateUrl(data.data.first ?? "")
            case .failure(let error):
                self?.isLoading = false
                print(error)
            }
        }
    }
}
